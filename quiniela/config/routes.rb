Rails.application.routes.draw do
  scope '/home' do 
    resources :players do
      collection do
        get :sign_up
        get :login
        get :logout
        post :login
        get 'profile/:id' => 'players#show', as: :profile
      end
    end
    resources :predictions
    resources :matches
    resources :teams
    resources :roles
    resources :leaderboards

    # Agregar ruta para la página de inicio (home)
    get '/', to: 'players#home', as: :home
  end 

  scope '/api' do
    resources :api_matches
    scope '/get_token' do
      get '/', to: 'application_api#get_token'
    end
    scope '/authorize_request' do
      get '/', to: 'application_api#authorize_request'
    end
  end
end
