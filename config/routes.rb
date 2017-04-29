Rails.application.routes.draw do
  scope :api, defaults: {format: :json} do
    resources :cities
    resources :states
  end
  
  root to: redirect("https://agustibr.github.io/capstone-2-spa-client-angular/dist")
end
