class ReservationValidator < ActiveModel::Validator
  def validate(record)
    if  record.end_date < record.start_date
      record.errors[:end_date] << "can't be before start date"
    elsif overlaping_reservation?(record)
      record.errors[:base] << "This reservation can't overlap an other one"
    end
  end

  def overlaping_reservation?(reservation_to_check)
    if reservation_to_check.listing.nil? == false
      all_reservation = reservation_to_check.listing.reservations
      all_reservation.each do |current_reservation|
        if ((reservation_to_check.end_date <= current_reservation.end_date && reservation_to_check.end_date > current_reservation.start_date) || (reservation_to_check.start_date >= current_reservation.start_date && reservation_to_check.start_date < current_reservation.end_date))
          return true
        end
      end
    end
    return false
  end
end