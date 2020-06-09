Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount_devise_token_auth_for 'User', at: '/api/v1/profile', controllers: {
    registrations: 'api/v1/registrations',
    sessions: 'api/v1/sessions'
  }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      get :status, to: 'api#status'

      devise_scope :user do
        resources :users, only: :update
        namespace :admin do
          resources :time_entries, only: %i[index create update destroy]
          resources :users, except: %i[new edit show]
        end
        resources :time_entries, only: %i[index create update destroy]
      end
    end
  end
end
