Rails.application.routes.draw do
  get 'boardgame/index', to: 'boardgame#index'
  post 'boardgame/index', to: 'boardgame#index'


  resources :seven_wonders do
  	collection do
  		get "players"
  		post "players"
  		get "review"
  		post "review"
      get "history"
      post "history"
  	  get "stats"
      post "stats"
      get "user"
      post "user"
      get "createPlayer"
      post "createPlayer"
      get "boardList"
      post "boardList"
    end
  end
  resources :swboardnames


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
