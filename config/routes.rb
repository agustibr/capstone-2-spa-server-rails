Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    resources :cities
    resources :states
  end
end
