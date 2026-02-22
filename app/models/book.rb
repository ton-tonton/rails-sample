class Book < ApplicationRecord
  enum :status, available: 0, rented: 1

  has_many :rentals, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: true
end
