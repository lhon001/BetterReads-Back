Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, :books, :shelves, :shelves_books
      get"/search/:term" => "search#show"
      get"/best-sellers" => "search#best_sellers"

      post"/login" => "users#login"
      get"/current_user" => "users#get_current_user"

      get"/users/:id/shelves" => "users#get_user_shelves"
    end
  end
end
