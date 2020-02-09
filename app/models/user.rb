class User < ApplicationRecord
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "please enter a valid email adress" }
  has_many :guested_reservations, foreign_key: 'guest', class_name: "Reservation"
  has_many :administred_listings, foreign_key: 'administrator', class_name: "Listing"
  validates :phone_number, presence: true, format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/, message: "please enter a valid french number" }
end
