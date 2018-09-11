module Api
  module Users
    module ShiftCoordinators
      module AccessControl
        extend ActiveSupport::Concern

        included do
          before_action :check_valid_permisson
        end

        def check_valid_permisson
          unless have_valid_permission?
            render json: { message: 'アクセス権限がありません' }, status: 404
          end
        end

        private

        def have_valid_permission?
          if action_name == 'index'
            @team.shift_coordinator?(current_user) && @team.active?
          else
            case @member.role
            when 'part_timer'
              @team.shift_coordinator?(current_user) && @team.active?
            when 'full_timer'
              @team.manager?(current_user) || @team.full_time_coordinator?(current_user) && @team.active?
            when 'manager'
              @team.manager?(current_user) && @team.active?
            end
          end
        end
      end
    end
  end
end
