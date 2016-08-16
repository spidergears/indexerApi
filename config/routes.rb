Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :indexed_urls, only: [:index, :create], param: :url
    end
  end
end
