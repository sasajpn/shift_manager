module Users
  module ShiftCoordinators
    module AccessControl
      extend ActiveSupport::Concern

      included do
        before_action :check_valid_permisson
      end

      def check_valid_permisson
        unless have_valid_permission?
          flash[:error] = 'リクエストされたページへのアクセス権限がありません'
          return redirect_to users_home_index_url
        end
      end

      private

      def have_valid_permission?
        if controller_name == 'teams' || action_name == 'index'
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
