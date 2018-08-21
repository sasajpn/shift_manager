module Users
  module PartTimers
    module AccessControl
      extend ActiveSupport::Concern

      def check_valid_permisson
        unless have_valid_permission?
          flash[:error] = 'リクエストされたページへのアクセス権限がありません'
          return redirect_to users_home_index_url
        end
      end

      private

      def have_valid_permission?
        if action_name == 'index'
          @team.part_time_coordinator?(current_user)
        else
          @team.part_time_coordinator?(current_user) && @member.part_timer?
        end
      end
    end
  end
end
