Rails.application.routes.draw do
  root to: "welcome#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # /@emmastone/story_title
  get '@:username/:story_id', to: 'welcome#show', as: 'story_page'
  
  # /@emmastone
  get '@:username', to: 'welcome#user', as: 'user_page'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :stories
end
