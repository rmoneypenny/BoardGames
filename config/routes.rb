Rails.application.routes.draw do
  get 'seven_wonders/new'

  resources :seven_wonders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
