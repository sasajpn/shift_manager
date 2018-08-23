module Api
  module Users
    module AccessControl
      extend ActiveSupport::Concern

      def check_valid_permisson
        unless have_valid_permission?
          render json: { message: 'アクセス権限がありません' }, status: 404
        end
      end

      private

      def have_valid_permission?
        if controller_name == 'teams' || ['index', 'new', 'create'].include?(action_name)
          @member.user == current_user
        else
          (eval "@#{controller_name.singularize}.user") == current_user
        end
      end
    end
  end
end
