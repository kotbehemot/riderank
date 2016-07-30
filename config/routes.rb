Rails.application.routes.draw do
  resources :taxi_rides, :only => [:create, :destroy] do
    delete :destroy_all, :on => :collection
  end
  root 'taxi_rides#index'
end
