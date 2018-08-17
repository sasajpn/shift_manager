module Users
  module FullTimers
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
          @team.full_timer?(current_user)
        else
          @team.full_timer?(current_user) && !@member.manager?
        end
      end
    end
  end
end
