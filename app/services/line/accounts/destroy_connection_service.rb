module Line
  module Accounts
    class DestroyConnectionService < Line::BaseService

      def destroy
        line_connection = get_line_connection
        if line_connection
          destroy_connection(line_connection)
        end
        message_destroyed_connection
      end

      private

      def get_line_connection
        LineConnection.find_by(line_user_id: line_user_id)
      end

      def destroy_connection(line_connection)
        line_connection.destroy
      end

      def message_destroyed_connection
        body = [
          {
            type: 'text',
            text: 'アカウントの連携を解除しました'
          }
        ]
        reply_message(body)
      end
      
    end
  end
end
