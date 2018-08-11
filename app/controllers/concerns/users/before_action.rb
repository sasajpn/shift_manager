module Users
  module BeforeAction
    extend ActiveSupport::Concern

    included do
      before_action :set_model
      before_action :set_resource, only: [:show, :edit, :update, :destroy]
      before_action :set_team
      before_action :set_current_member

      private

      def set_model
        @model = controller_name.classify.constantize
      end

      def model_name
        @model.to_s
      end

      def set_resource
        instance_variable_set :"@#{controller_name.singularize}", @model.find(params[:id])
      end

      def set_team
        super
        @team ||= eval "@#{controller_name.singularize}&.team"
      end

      def set_current_member
        @current_member = current_user.approval_members.find_by(team_id: @team.id)
      end
    end
  end
end
