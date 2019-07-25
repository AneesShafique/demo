Rails.application.routes.draw do
  resources :charges, only: [:create]

  resources :line_items do
    patch 'decrease', on: :member
  end

  resources :carts, only: %i[index new create update destroy show]
  root to: 'products#index'

  resources :products do
    resources :reviews, only: %i[new create show update destroy]
    collection do
      get 'search'
    end
    member do
      delete :remove_attachment
    end
  end

  devise_for :user, controllers: { registrations: 'user/registrations' }
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
