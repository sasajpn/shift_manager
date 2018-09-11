module Api
  module Users
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

      def access_member
        @member || (eval "@#{controller_name.singularize}")
      end

      def have_valid_permission?
        access_member.user == current_user && access_member.team.active?
      end
    end
  end
end
