class Api::V1::ShelvesController < ApplicationController
  before_action :find_shelf, only: [:show, :delete, :update]

  def index
    shelves = Shelf.all
    render json: shelves
  end

  def show
    render json: @shelf
  end

  def create
    shelf = Shelf.create(name: shelf_params[:name], user_id: shelf_params[:user_id])
    render json: shelf, status: :created
  end

  def delete
    Shelf.destroy(shelf_params)
  end

  def update
    @shelf.update(shelf_params)
    if @shelf.save
      render json @shelf, status: :accepted
    else
      render json: {errors: @shelf.errors.full_messages}, status: :unprocessible_entity
    end
  end

  private

  def shelf_params
    params.permit(:name, :user_id)
  end

  def find_shelf
    @shelf = Shelf.find(params[:id])
  end

end
