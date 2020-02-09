# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'database_cleaner-active_record'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean


#USERS
20.times do |k|
  User.create(email: Faker::Internet.email, phone_number: "0" + rand(100000000..999999999).to_s, description: Faker::Books::Lovecraft.paragraph)
end

#CITIES
10.times do
  zip_code_temp = rand(0..8).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s 
  City.create(name: Faker::Address.city, zip_code: zip_code_temp)
end

#LISTINGS
50.times do |k|
  puts k
  temp_available_beds = rand(2..10)
  temp_price = rand(40..80) * temp_available_beds
  temp_description = Faker::Books::Lovecraft.paragraph_by_chars(characters: rand(140..240))
  temp_has_wifi = [true, false][rand(0..1)]
  temp_welcome_message = Faker::Books::Lovecraft.paragraph_by_chars(characters: rand(100..200))
  temp_city = City.all.sample
  temp_administrator = User.all.sample

  temp_listing = Listing.new(available_beds: temp_available_beds, price: temp_price, description: temp_description, has_wifi: temp_has_wifi, welcome_message: temp_welcome_message, city: temp_city, administrator: temp_administrator)
  if (temp_listing.valid? == false)
    temp_listing.errors.messages
  else
    temp_listing.save
  end
end

#RESERVATIONS
#Chaque reservation peut avoir sa date de depart etre au maximum il y a 10mois, et sa duree max est de 7 jours, c'est juste un choix perso
Listing.all.each do |current_listing|
  5.times do
    temp_reservation = nil
    while (temp_reservation.nil? == true || temp_reservation.valid? == false)
      temp_start_date = Time.now - rand(1..60) * 60 - rand(1..24) * 3600 - rand(7..31) * 3600 * 24 - rand(0..10) * 3600 * 24 * 30
      temp_end_date = temp_start_date + rand(1..7) * 3600 * 24
      while((temp_guest = User.all.sample) == current_listing.administrator)
      end
      temp_reservation = Reservation.new(start_date: temp_start_date, end_date: temp_end_date, listing: current_listing, guest: temp_guest)
    end
    temp_reservation.save
  end
  5.times do
    temp_reservation = nil
    while (temp_reservation.nil? || temp_reservation.valid? == false)
      temp_start_date = Time.now + rand(1..60) * 60 + rand(1..24) * 3600 + rand(7..31) * 3600 * 24 + rand(0..10) * 3600 * 24 * 30
      temp_end_date = temp_start_date + rand(1..24) * 3600 * 24
      while((temp_guest = User.all.sample) == current_listing.administrator)
      end
      temp_reservation = Reservation.new(start_date: temp_start_date, end_date: temp_end_date, listing: current_listing, guest: temp_guest)
    end
    temp_reservation.save
  end
end
