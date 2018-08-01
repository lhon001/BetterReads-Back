class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: [:update, :show]

  def index
    all_users = User.all
    render json: all_users
  end

  def show
    render json: @user
  end

  def create
    user = User.create(name: user_params[:name], username: user_params[:username].downcase, password: user_params[:password])

    if user.valid?
      default_shelf = Shelf.create(name: "Wishlist", user_id: user.id)
      default_book = Book.create(title: "The Great Gatsby", author: "F. Scott Fitzgerald", description: "A true classic of twentieth-century literature, this edition has been updated by Fitzgerald scholar James L.W. West III to include the author’s final revisions and features a note on the composition and text, a personal foreword by Fitzgerald’s granddaughter, Eleanor Lanahan—and a new introduction by two-time National Book Award winner Jesmyn Ward. The Great Gatsby, F. Scott Fitzgerald’s third book, stands as the supreme achievement of his career. First published in 1925, this quintessential novel of the Jazz Age has been acclaimed by generations of readers. The story of the mysteriously wealthy Jay Gatsby and his love for the beautiful Daisy Buchanan, of lavish parties on Long Island at a time when The New York Times noted “gin was the national drink and sex the national obsession,” it is an exquisitely crafted tale of America in the 1920s.", image: "http://books.google.com/books/content?id=iXn5U2IzVH0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
      default_shelvesbook = ShelvesBook.create(shelf_id: default_shelf.id, book_id: default_book.id)
      render json: {token: issue_token({id: user.id})}, status: :created
    else
      render json: {error: "user not created"}
    end

  end

  def delete
    User.destroy(user_params[user_id])
  end

  def update
    @user.update(user_params)
    if @user.save
      render json: @user, status: :accepted
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessible_entity
    end
  end

  def login
    user = User.find_by(username: user_params[:username].downcase)
    if user && user.authenticate(user_params[:password])
      render json: {token: issue_token({id: user.id})}
    else
      render json: {error: "login failed"}, status: 401
    end
  end

  def get_current_user
    render json: current_user
  end

  def get_user_shelves
    users_shelves_books = current_user.shelves.map do |shelf|
      shelf.books
    end
    all = current_user.shelves.zip(users_shelves_books)
    puts all
    # shelf1: [book1, book2], shelf2: [book1, book2]
    render json: all
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
