class Api::V1::BooksController < ApplicationController
before_action :find_book, only: [:show, :update]

  # show a book that user has favorited
  def show
    render json: @book
  end

  #show all books user has favorited
  def index
    books = Book.all
    render json: books
  end

  # create by favoriting a book
  def create
    book = Book.create(book_params)
    render json: book, status: :created
  end

  # remove a favorited book by deleting
  def delete
    Book.destroy(book_params[book_id])
  end

  private

  def book_params
    params.permit(:title, :author, :book_id)
  end

  def find_book
    @book = Book.find(params[:id])
  end

end
