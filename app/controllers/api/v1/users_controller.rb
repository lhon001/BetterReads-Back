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
    # byebug
    user = User.create(name: user_params[:name], username: user_params[:username].downcase, password: user_params[:password])
    if user.valid?
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
    byebug
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

  private

  def user_params
    params.require(:user).permit(:name, :username, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
