class Rental < ApplicationRecord
  belongs_to :book

  validates :renter_name, presence: true
  validates :rented_at, presence: true

  validate :book_must_be_available, on: :create

  after_create :mark_book_as_rented
  after_update :mark_book_as_available, if: -> { saved_change_to_returned_at? && returned_at.present? }

  private

  def book_must_be_available
    return if book.available?

    errors.add(:base, "This book is currently rented.")
  end

  def mark_book_as_rented
    book.rented!
  end

  def mark_book_as_available
    book.available!
  end
end
