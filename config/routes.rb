Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index
  root :to => "ticker#home"
  get 'home', to:'ticker#home'
  get 'eth', to:'ticker#eth'
  get 'btc', to:'ticker#btc'

end
