module Api
  module Owners
    module AccessControl
      extend ActiveSupport::Concern

      def check_valid_permisson
        unless have_valid_permission?
          render json: { message: 'アクセス権限がありません' }, status: 404
        end
      end

      private

      def access_team
        @team || (eval "@#{controller_name.singularize}.team")
      end

      def have_valid_permission?
        access_team.owner == current_owner && access_team.active?
        # if controller_name == 'teams' || ['index', 'new', 'create'].include?(action_name)
        #   @team.owner == current_owner && @team.active?
        # else
        #   team = (eval "@#{controller_name.singularize}.team")
        #   team.owner == current_owner && team.active?
        # end
      end
    end
  end
end
