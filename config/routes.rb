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

  namespace :admins do
    resources :home, only: [:index]
    resources :owners do
      resources :teams, except: [:index], shallow: true do
        patch :update_identifier, on: :member
        resources :members do
          resources :shift_submissions do
            resources :shift_adjustments
          end
        end
      end
    end
    resources :teams, only: [:index]
    resources :users
  end

  namespace :api, { format: 'json' } do
    namespace :v1 do
      namespace :admins do
        resources :shift_submissions, only: [:edit], shallow: true do
          resources :shift_adjustments, only: [:show, :new, :edit]
        end
      end
    end
  end

end
