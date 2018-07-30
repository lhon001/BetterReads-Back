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
    user = User.create(name: user_params[:name], username: user_params[:username], password: user_params[:password])
    render json: user, status: :created
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

  private

  def user_params
    params.permit(:name, :username, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
