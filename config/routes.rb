
Rails.application.routes.draw do

  devise_for :admins, :controllers => { :sessions => 'admin/sessions', :passwords => 'admin/passwords' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'home#index'

  namespace :api, defaults: { format: :json }  do
    get    'hotels',      to: 'hotels#index'
    get    'hotels/:id',  to: 'hotels#find'
    put    'hotels/:id',  to: 'hotels#update'
    delete 'hotels/:id',  to: 'hotels#destroy'
    post   'hotels',      to: 'hotels#create'
    get    'search',      to: 'hotels#search'
  end
end
