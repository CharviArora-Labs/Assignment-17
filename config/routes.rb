Rails.application.routes.draw do
  get "/health", to: proc { [ 200, {}, [ "OK" ] ] }
  namespace :api do
    namespace :v1 do
      resources :users, only: [ :index ]
    end
  end
end
