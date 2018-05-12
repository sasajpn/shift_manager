module Line
  module Accounts
    class DestroyConnectionService < Line::BaseService

      def destroy
        line_connection = get_line_connection
        if line_connection
          destroy_connection(line_connection)
          message_destroyed_connection
        else
          message_account_not_link
        end
      end

      private

      def get_line_connection
        LineConnection.find_by(line_user_id: line_user_id)
      end

      def destroy_connection(line_connection)
        line_connection.destroy
      end

      def message_destroyed_connection
        data = [
          {
            type: 'text',
            text: 'アカウントの連携を解除しました'
          }
        ]
        post(data: data)
      end

      def message_account_not_link
        data = [
          {
            type: 'text',
            text: 'アカウントは連携されていません'
          }
        ]
        post(data: data)
      end

    end
  end
end
