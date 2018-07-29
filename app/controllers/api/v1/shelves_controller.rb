class Api::V1::ShelvesController < ApplicationController
  before_action :find_shelf, only: [:show, :delete, :update]

  def index
    shelves = Shelf.all
  end

  def show
    render json: @shelf
  end

  def create
    shelf = Shelf.create(name: shelf_params[:name], user_id: shelf_params[:user_id])
    render json: shelf
  end

  def delete

  end

  private

  def shelf_params
    params.permit(:name, :user_id)
  end

  def find_shelf
    @shelf = Shelf.find(params[:id])
  end


end
