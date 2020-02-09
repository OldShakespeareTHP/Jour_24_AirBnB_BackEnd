require 'time_difference'
require_relative 'validators/reservation_validator'

class Reservation < ApplicationRecord
  belongs_to :guest, class_name: "User"
  belongs_to :listing
  validates_with ReservationValidator

  def duration
    TimeDifference.between(self.start_date, self.end_date).humanize
  end
end
