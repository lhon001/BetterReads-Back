class Api::V1::SearchController < ApplicationController

  def show
    search_terms = search_params.gsub(' ','+')
    response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{search_terms}&key=AIzaSyCL8n_5M0ZNxlwFr9IM2YIkU4MjS-a4TWw")
    render json: response
  end

  private

  def search_params
    # @search_terms = params[:input]
    return "A Moveable Feast"
  end

end
