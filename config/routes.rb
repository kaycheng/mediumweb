Rails.application.routes.draw do
  root to: "welcome#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  namespace :api do
    post :upload_image, to: 'utils#upload_image'

    resources :users, only: [] do
      member do
        post :follow
      end
    end

    resources :stories, only: [] do
      member do
        post :clap
        post :bookmark
      end
    end
  end

  resources :users, only: [] do
    collection do
      get :pricing # /users/pricing
      get :payment # /users/payment
      post :pay # /users/pay
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
