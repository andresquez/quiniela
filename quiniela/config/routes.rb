Rails.application.routes.draw do
  resources :predictions
  resources :matches
  resources :teams
  resources :roles
  resources :leaderboards
  resources :players do
    collection do
      # get 'login'
      post 'login'
      # get 'profile'
    end
  end

  scope '/home' do
    get 'sign_up' => 'players#sign_up'
    get 'login' => 'players#login'
    # get 'profile:id' => 'players#show'
    get 'leaderboard' => 'leaderboards#index'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
