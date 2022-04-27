Rails.application.routes.draw do
  scope :api do
    resources :messages
    resources :rooms
    resources :users
  end
end
