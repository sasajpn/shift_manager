module Line
  module Accounts
    class CancelDestroyedConnectionService < Line::BaseService

      def cancel
        message_cancel_destroyed_connection
      end

      private

      def message_cancel_destroyed_connection
        data = [
          {
            type: 'text',
            text: 'アカウントの連携解除をキャンセルしました'
          }
        ]
        post(data: data)
      end

    end
  end
end
