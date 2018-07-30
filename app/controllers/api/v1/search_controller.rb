class Api::V1::SearchController < ApplicationController

  def show
    response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{search_params}&key=AIzaSyCL8n_5M0ZNxlwFr9IM2YIkU4MjS-a4TWw")
    # format response to a universal format for our use
    render json: response
  end

  def best_sellers
    apiKey = '51b3ad4766fd48239a1a0d28d35f0814'
    response = RestClient.get("https://api.nytimes.com/svc/books/v3/lists/overview.json?api-key=#{apiKey}")
    # format response to a universal format for our use 
    render json: response
  end

  private

  def search_params
    params[:term]
  end

end
