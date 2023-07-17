Rails.application.routes.draw do
  resources :predictions
  resources :matches
  resources :teams
  resources :roles
  resources :leaderboards
  resources :players

  scope '/home' do
    get 'sign_up' => 'players#sign_up'
    post 'sign_up' => 'players#create'
    get 'login' => 'players#login'
    post 'login' => 'players#login'
    get 'profile/:id' => 'players#show'
    get 'leaderboard' => 'leaderboards#index'
    get 'predictions' => 'predictions#index'
    get 'matches' => 'matches#index'
    get 'matches/:id' => 'matches#show'
  end

end
