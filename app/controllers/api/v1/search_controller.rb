class Api::V1::SearchController < ApplicationController

  def show
    response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{search_params}&key=AIzaSyCL8n_5M0ZNxlwFr9IM2YIkU4MjS-a4TWw")
    render json: response
  end

  private

  def search_params
    params[:term]
  end

end
