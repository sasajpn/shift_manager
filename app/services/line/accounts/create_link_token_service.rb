module Line
  module Accounts
    class CreateLinkTokenService < Line::BaseService

      def create
        link_token = request_link_token
        message_account_link_url(link_token)
      end

      private

      def request_link_token
        res = post(path: "user/#{line_user_id}/linkToken")
        ActiveSupport::JSON.decode(res.body)['linkToken']
      end

      def message_account_link_url(link_token)
        data = [
          {
            type: 'template',
            altText: 'This is a buttons template',
            template: {
              type: 'buttons',
              title: 'シフトマネージャーアカウントとの連携',
              text: '※連携後は連携解除ボタンからもしくはブロックすることでいつでも連携を解除することができます',
              actions: [
                {
                  type: 'uri',
                  label: 'アカウントを連携する',
                  uri: "#{ENV['NGROK_URL']}/users/line_connections/new?linkToken=#{link_token}"
                }
              ]
            }
          }
        ]
        post(data: data)
      end

    end
  end
end
