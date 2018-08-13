module Api
  module Owners
    module AccessControl
      extend ActiveSupport::Concern

      def check_valid_permisson
        unless have_valid_permission?
          render json: { message: 'アクセス権限がありません' }, status: 404
        end
      end

      def have_valid_permission?
        team.owner == current_owner
      end

      private

      def team
        if controller_name == 'teams'
          @team
        else
          (eval "@#{controller_name.singularize}&.team") || @team
        end
      end
    end
  end
end
