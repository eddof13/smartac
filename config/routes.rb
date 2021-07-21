Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :devices, only: [:create] do
    resources :sensor_data, only: [:create]
  end

  get '/admin/:device_id', to: 'admin#show'
  
  root "admin#index"
end
