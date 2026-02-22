class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :books, :title, unique: true
  end
end
