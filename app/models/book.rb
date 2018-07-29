class Book < ApplicationRecord
  has_many :shelves_books
  has_many :shelves, through: :shelves_books
end
