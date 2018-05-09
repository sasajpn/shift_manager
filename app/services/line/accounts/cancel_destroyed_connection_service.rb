module Line
  module Accounts
    class CancelDestroyedConnectionService < Line::BaseService

      def cancel
        message_cancel_destroyed_connection
      end

      private

      def message_cancel_destroyed_connection
        body = [
          {
            type: 'text',
            text: 'アカウントの連携解除をキャンセルしました'
          }
        ]
        reply_message(body)
      end

    end
  end
end
