Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :channels do
    resources :rooms
  end
  resources :users

  post '/add_channel/:user_id/:channel_id', to: 'registrations#add_channel', as: "add_channel"
  delete '/drop_channel/:user_id/:channel_id', to: 'registrations#drop_channel', as: "drop_channel"

  post '/refresh', to: 'rooms#refresh', as: "refresh"
end