Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
  }

  devise_for :owners, controllers: {
    sessions:      'owners/sessions',
    passwords:     'owners/passwords',
    registrations: 'owners/registrations',
    confirmations: 'owners/confirmations'
  }

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
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

  namespace :owners do
    namespace :members do
      resources :unapprovals
    end
    resources :home, only: [:index]
    resources :owners, only: [:edit, :update]
    resources :teams, except: [:update], shallow: true do
      patch :update_identifier, on: :member
      resources :members, except: [:new, :create] do
        resources :shift_submissions, only: [:new]
      end
      resources :shift_adjustments, only: [:index]
      resources :shift_submissions, except: [:new, :create, :update] do
        resources :shift_adjustments, except: [:index, :create, :update]
      end
    end
  end

  namespace :users do
    namespace :members do
      resources :unapprovals, only: [:index, :show, :new, :destroy]
    end
    namespace :shift_coordinators do
      resources :teams, only: [], shallow: true do
        resources :members, only: [:index, :show] do
          resources :shift_submissions, only: [:new, :destroy] do
            resources :shift_adjustments, only: [:new, :edit, :destroy]
          end
        end
        resources :shift_submissions, only: [:index]
        resources :shift_adjustments, only: [:index]
      end
    end
    resources :home, only: [:index]
    resources :users, only: [:edit, :update]
    resources :teams, only: [:index, :show], shallow: true do
      resources :shift_adjustments, only: [:index]
      resources :shift_submissions, except: [:create, :update]
    end
    resources :members, except: [:index, :new, :create, :show]
    resources :line_connections, only: [:new, :create]
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

      namespace :owners do
        resources :teams, only: [:show, :create, :edit, :update], shallow: true do
          resources :shift_submissions, except: [:index, :new, :create, :destroy] do
            resources :shift_adjustments, except: [:index, :destroy]
          end
        end
        resources :members, only: [:edit, :update], shallow: true do
          resources :shift_submissions, only: [:new, :create]
        end
      end

      namespace :users do
        namespace :members do
          resources :unapprovals, only: [:create]
        end
        namespace :shift_coordinators do
          resources :members, only: [], shallow: true do
            resources :shift_submissions, only: [:new, :create] do
              resources :shift_adjustments, only: [:new, :create, :edit, :update]
            end
          end

        end
        resources :home, only: [:index]
        resources :teams, only: [:show], shallow: true do
          resources :shift_submissions, except: [:index, :destroy]
        end
        resources :members, only: [:edit, :update]

      end

    end
  end

end
