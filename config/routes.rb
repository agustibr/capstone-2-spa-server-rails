Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    resources :cities
    resources :states
  end

  get '/ui' => 'ui#index'
  get '/ui#' => 'ui#index'
  root 'ui#index'
end
