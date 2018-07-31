class User < ApplicationRecord
  has_secure_password
  has_many :shelves
  # allows for user_1.books to return all books belonging to user_1
  has_many :books, through: :shelves
end
