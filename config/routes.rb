Rails.application.routes.draw do
  root to: "welcome#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [] do
    member do
      post :follow
    end
  end

  # /@emmastone/story_title
  get '@:username/:story_id', to: 'welcome#show', as: 'story_page'
  
  # /@emmastone
  get '@:username', to: 'welcome#user', as: 'user_page'

  get 'demo', to: 'welcome#demo'

  resources :stories do
    member do
      post :clap
    end
    resources :comments, only: [:create]
  end
end
