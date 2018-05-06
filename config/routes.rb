Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
  }

  devise_for :owners, controllers: {
    sessions:      'owners/sessions',
    passwords:     'owners/passwords',
    registrations: 'owners/registrations'
  }

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }

  namespace :line do
    post '/callback', to: 'webhook#callback'
  end

  namespace :admins do
    resources :home, only: [:index]
    resources :line_connections, only: [:new, :create]
    resources :line_richmenus
    resources :owners do
      resources :teams, except: [:index], shallow: true do
        patch :update_identifier, on: :member
        resources :shift_submissions, only: [:index]
        resources :shift_adjustments, only: [:index]
        resources :members do
          resources :shift_submissions, except: [:index] do
            resources :shift_adjustments, except: [:index]
          end
        end
      end
    end
    resources :teams, only: [:index]
    resources :users
  end

  namespace :users do
    resources :home, only: [:index]
    resources :teams, only: [:index, :show], shallow: true do
      resources :shift_adjustments, only: [:index]
      resources :shift_submissions do
        resources :shift_adjustments, except: [:index]
      end
    end
    resources :members, only: [:new, :create]
  end

  namespace :api, { format: 'json' } do
    namespace :v1 do
      namespace :admins do
        resources :teams, only: [:edit], shallow: true do
          resources :members do
            resources :shift_submissions, only: [:new, :edit]
          end
        end
        resources :shift_submissions, only: [:new, :edit], shallow: true do
          resources :shift_adjustments, only: [:show, :new, :edit]
        end
      end
      namespace :users do
        resources :home, only: [:index]
        resources :teams, only: [:show], shallow: true do
          resources :shift_submissions, only: [:new, :edit] do
            resources :shift_adjustments, only: [:show, :new, :edit]
          end
        end
      end
    end
  end

end
