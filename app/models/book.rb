class Book < ApplicationRecord
  enum :status, available: 0, rented: 1

  has_many :rentals, dependent: :destroy
  has_one :active_rental, -> { where(returned_at: nil).order(id: :desc) }, class_name: "Rental"

  validates :title, presence: true
  validates :title, uniqueness: true
end
