# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  mount Rswag::Api::Engine => '/api-docs'

  get '/admin', to: redirect('/admin/short_links')

  namespace :api do
    namespace :v1 do
      resources :short_links, only: %i[index create show destroy]
    end
  end

  namespace :admin do
    resources :short_links, only: %i[index create destroy]
    get 'cleanup', to: 'short_links#cleanup'
  end

  get '/:id', to: 'admin/short_links#show'
  get 'admin/short_links/:id', to: 'admin/short_links#show', as: 'admin_short_link_show'
  root to: 'admin/short_links#index'
end
