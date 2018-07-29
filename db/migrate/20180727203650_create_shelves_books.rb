class CreateShelvesBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :shelves_books do |t|
      t.integer :shelf_id
      t.integer :book_id

      t.timestamps
    end
  end
end
