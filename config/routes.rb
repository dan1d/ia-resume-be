Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do 
      resources :resumes, only: [:index, :create, :show]
    end
  end
end
