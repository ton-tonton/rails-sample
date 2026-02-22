class Rental < ApplicationRecord
  belongs_to :book

  validates :renter_name, presence: true
  validates :rented_at, presence: true
end
