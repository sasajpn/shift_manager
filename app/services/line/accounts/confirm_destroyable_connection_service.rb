module Line
  module Accounts
    class ConfirmDestroyableConnectionService < Line::BaseService

      def confirm
        message_confirm_destroyable_connection
      end

      private

      def message_confirm_destroyable_connection
        body = [
          {
            type: 'template',
            altText: 'This is a confirm template',
            template: {
              type: 'confirm',
              text: "アカウントの連携を解除しますか？",
              actions: [
                {
                  type: 'postback',
                  label: 'はい',
                  data: 'destroy_connection[OK]'
                },
                {
                  type: 'postback',
                  label: 'いいえ',
                  data: 'destroy_connection[NG]'
                }
              ]
            }
          }
        ]
        reply_message(body)
      end

    end
  end
end
