Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/failure'

  get 'workflows/list/:repo/:workflow/:id/:branch' , action: :show , controller:  'releases'  , as: 'workflows'

  get 'releases/list/:repo/:workflow/'             , action: :release , controller:  'releases'  , as: 'releases'

  root 'releases#view'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #Omni Auth for Github
  get "/auth/github/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout
  get "/signup" => redirect("/auth/github"), :as => :signup

  #Sidekiq Dashboard
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'
end
