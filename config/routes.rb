Rails.application.routes.draw do
  resources :taxi_rides, :only => [:index, :create, :destroy]
  delete 'taxi_rides' => 'taxi_rides#destroy_all', :as => :destroy_all_taxi_rides
  root 'taxi_rides#index'
end
