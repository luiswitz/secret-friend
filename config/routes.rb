require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  root to: 'pages#home'

  get 'campaigns/:id/confirm_destroy', to: 'campaigns#confirm_destroy', as: :confirm_destroy_campaign
  resources :campaigns, except: [:new] do
    post 'raffle', on: :member
  end

  get 'members/:token/opened', to: 'members#opened'
  resources :members, only: [:create, :destroy, :update]
end
