Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # API Endpoints with Versioning
  namespace :api do
    namespace :v1 do
      resources :orders do
        # Member routes act on a single specific record (requires an :id parameter)
        member do
          post :process_tax
        end

        # Collection routes act on the entire collection of records (does not require an :id)
        collection do
          get :pending_deliveries
        end
      end
      resources :customers, only:[:create, :update]
    end
  end
end