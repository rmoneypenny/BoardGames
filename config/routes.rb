Rails.application.routes.draw do
  #get 'seven_wonders#index'

  resources :seven_wonders
  resources :swboardnames
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
