class Shelf < ApplicationRecord
  belongs_to :user
  has_many :shelves_books
  has_many :books, through: :shelves_books
end
