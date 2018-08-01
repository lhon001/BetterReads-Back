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
    book = Book.create(title: book_params[:title], author: book_params[:author], description: book_params[:description], image: book_params[:image])
    if book.valid?
      x = ShelvesBook.create(shelf_id: params["shelf"], book_id: book.id)
      byebug
      render json: book, status: :created
    else
      render json: {error: "book not created"}
    end
  end

  # remove a favorited book by deleting
  def delete
    Book.destroy(book_params[book_id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :image, :description)
  end

  def find_book
    @book = Book.find(params[:id])
  end

end
