module Users
  module Action
    extend ActiveSupport::Concern

    included do

      def index
      end

      def show
      end

      def new
      end

      def create
      end

      def edit
      end

      def update
      end

      def destroy
      end

      private

      def resource_params
        params.require(model_name.underscore.intern).permit(*@model.column_names.map(&:intern))
      end
    end
  end
end
