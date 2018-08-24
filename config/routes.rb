Rails.application.routes.draw do

# Devise
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

# LINE CALLBACK
  namespace :line do
    post '/callback', to: 'webhook#callback'
  end

# WEB

  # 管理者
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

  # オーナー
  namespace :owners do
    resources :home, only: [:index]
    resource :owner, only: [:edit, :update] do
      get :destroy_unconfirmed_email, on: :collection
      patch :destroy_unconfirmed_email, on: :collection
    end
    resources :teams, except: [:update], shallow: true do
      namespace :members do
        resources :unapprovals
      end
      patch :update_identifier, on: :member
      resources :members, except: [:new, :create, :update] do
        resources :shift_registrations, only: [:show, :new, :edit]
      end
      resources :shift_adjustments, only: [:index]
      resources :shift_submissions, except: [:new, :create, :update] do
        resources :shift_adjustments, except: [:index, :create, :update]
      end
    end
  end

  # ユーザー
  namespace :users do

    namespace :members do
      resources :unapprovals, only: [:index, :show, :new, :destroy]
    end

    # シフト調整者用
    namespace :shift_coordinators do
      resources :teams, only: [], shallow: true do
        patch :update_identifier, on: :member
        resources :members, only: [:index, :show, :edit] do
          resources :shift_registrations, only: [:new, :edit]
          resources :shift_submissions, only: [:show] do
            resources :shift_adjustments, only: [:new, :edit, :destroy]
          end
        end
        resources :shift_submissions, only: [:index]
        resources :shift_adjustments, only: [:index]
      end
    end

    # Manager
    namespace :managers do
      resources :teams, only: [], shallow: true do
        patch :update_identifier, on: :member
        resources :members, only: [:index, :show, :edit] do
          resources :shift_registrations, only: [:new, :edit]
          resources :shift_submissions, only: [:show] do
            resources :shift_adjustments, only: [:new, :edit, :destroy]
          end
        end
        resources :shift_submissions, only: [:index]
        resources :shift_adjustments, only: [:index]
      end
    end

    # FullTimer
    namespace :full_timers do
      resources :teams, only: [], shallow: true do
        resources :members, only: [:index, :show, :edit] do
          resources :shift_registrations, only: [:new, :edit]
          resources :shift_submissions, only: [:show] do
            resources :shift_adjustments, only: [:new, :edit, :destroy]
          end
        end
        resources :shift_submissions, only: [:index]
        resources :shift_adjustments, only: [:index]
      end
    end

    # PartTimer
    namespace :part_timers do
      resources :teams, only: [], shallow: true do
        resources :members, only: [:index, :show, :edit] do
          resources :shift_registrations, only: [:new, :edit]
          resources :shift_submissions, only: [:show] do
            resources :shift_adjustments, only: [:new, :edit, :destroy]
          end
        end
        resources :shift_submissions, only: [:index]
        resources :shift_adjustments, only: [:index]
      end
    end

    # User共通
    resources :home, only: [:index]
    resource :user, only: [:edit, :update] do
      get :destroy_unconfirmed_email, on: :collection
      patch :destroy_unconfirmed_email, on: :collection
    end
    resources :members, only: [:index, :show, :edit, :destroy], shallow: true do
      resources :shift_submissions, except: [:create, :update]
      resources :shift_adjustments, only: [:index]
    end
    resources :line_connections, only: [:new, :create]
  end


  # API

  namespace :api, { format: 'json' } do
    namespace :v1 do

      # 管理者
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

      # オーナー
      namespace :owners do
        resources :teams, only: [:show, :create, :edit, :update], shallow: true do
          scope module: :teams do
            resources :calendars, only: [:index]
          end
          resources :shift_tables, only: [:index]
          resources :members, only: [:show, :edit, :update] do
            scope module: :members do
              resources :calendars, only: [:index]
            end
            resources :shift_registrations, only: [:show, :create, :update]
          end
          resources :shift_submissions, only: [:index, :show] do
            resources :shift_adjustments, only: [:show, :create, :update]
          end
          resources :shift_adjustments, only: [:index]
        end
        resources :members, only: [:edit, :update]
      end

      # ユーザー
      namespace :users do

        namespace :members do
          resources :unapprovals, only: [:create]
        end

        # Manager
        namespace :managers do
          resources :members, only: [:edit, :update]
          resources :teams, only: [], shallow: true do
            resources :members, only: [:show]
            resources :shift_submissions, only: [:index]
            resources :shift_adjustments, only: [:index]
          end
        end

        # FullTimer
        namespace :full_timers do
          resources :teams, only: [], shallow: true do
            resources :members, only: [:show]
            resources :shift_submissions, only: [:index]
            resources :shift_adjustments, only: [:index]
          end
        end

        # PartTimer
        namespace :part_timers do
          resources :teams, only: [], shallow: true do
            resources :members, only: [:show]
            resources :shift_submissions, only: [:index]
            resources :shift_adjustments, only: [:index]
          end
        end

        # User共通
        resources :home, only: [:index]
        resources :teams, only: [:show], shallow: true do
          scope module: :teams do
            resources :calendars, only: [:index]
          end
          resources :members, only: [:show, :update] do
            resources :calendars, only: [:index]
            resources :shift_registrations, only: [:show, :create, :update]
          end
          resources :shift_submissions, except: [:destroy], shallow: true do
            resources :shift_adjustments, only: [:show, :create, :update]
          end
        end
      end
    end
  end
end
