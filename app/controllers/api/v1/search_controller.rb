class Api::V1::SearchController < ApplicationController

  def show
    response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{search_params}&key=AIzaSyCL8n_5M0ZNxlwFr9IM2YIkU4MjS-a4TWw")
    # format response to a universal format for our use
    # title, author, image, description
    # byebug

    jsoned_response = JSON.parse(response)

    formatted_response = jsoned_response["items"].map do |info|
      {id: info["volumeInfo"]["industryIdentifiers"][0]["identifier"],
      title: info["volumeInfo"]["title"],
      author: info["volumeInfo"]["authors"],
      description: info["volumeInfo"]["description"],
      image: info["volumeInfo"]["imageLinks"] ? info["volumeInfo"]["imageLinks"]["thumbnail"] : nil}
    end

    render json: formatted_response
  end

  def best_sellers
    apiKey = '51b3ad4766fd48239a1a0d28d35f0814'
    response = RestClient.get("https://api.nytimes.com/svc/books/v3/lists/overview.json?api-key=#{apiKey}")
    # format response to a universal format for our use
    # title, author, image, description
    jsoned_response = JSON.parse(response)
    random = rand(0..12)
    formatted_response = jsoned_response["results"]["lists"][random]["books"].map do |book|
      {id: book["primary_isbn13"],
      title:book["title"],
      author: book["author"],
      description: book["description"],
      image: book["book_image"]}
    end

    render json: formatted_response
  end

  private

  def search_params
    params[:term]
  end

end
