module Users
  module Managers
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
        @team.manager?(current_user)
      end
    end
  end
end