Rails.application.routes.draw do
  post 'search', to: 'home#search'
  root 'home#index'
end
