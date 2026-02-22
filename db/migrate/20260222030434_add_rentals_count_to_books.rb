class AddRentalsCountToBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :books, :rentals_count, :integer, default: 0, null: false
  end
end
