Rails.application.routes.draw do
  namespace :admin do
    resources 'authors'
  end

  get 'about', to: 'about#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
