Rails.application.routes.draw do
  resources :feeds do
    collection do
      post :confirm
    end
  end
  # mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :sessions, only: [:new, :create, :destroy]
  get '/sessions', to: 'sessions#new'
  get 'sessions/new'
  resources :users, only: [:new, :create, :show, :edit, :update]
  get '/', to: 'users#new'
  resources :favorites, only: [:create, :destroy, :index]
end
