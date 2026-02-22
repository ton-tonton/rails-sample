json.extract! rental, :id, :book_id, :renter_name, :rented_at, :returned_at, :created_at, :updated_at
json.url rental_url(rental, format: :json)
