class CreateRentals < ActiveRecord::Migration[8.1]
  def change
    create_table :rentals do |t|
      t.references :book, null: false, foreign_key: true
      t.string :renter_name, null: false
      t.datetime :rented_at, null: false
      t.datetime :returned_at

      t.timestamps
    end
  end
end
