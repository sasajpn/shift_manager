require 'net/https'

module Line
  class CreateLinkTokenService
    def initialize(reply_token, line_user_id)
      @reply_token = reply_token
      @line_user_id = line_user_id
    end

    def create
      link_token = request_link_token
      message_account_link_url(link_token)
    end

    private

    attr_reader :reply_token, :line_user_id

    def request_link_token
      uri = URI.parse("https://api.line.me/v2/bot/user/#{line_user_id}/linkToken")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      res = http.request(req)
      ActiveSupport::JSON.decode(res.body)['linkToken']
    end

    def message_account_link_url(link_token)
      uri = URI.parse("https://api.line.me/v2/bot/message/reply")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Content-Type"] = "application/json"
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      req.body = {
        "replyToken": "#{reply_token}",
        "messages": [
          {
            "type": "template",
            "altText": "Account Link",
            "template": {
              "type": "buttons",
              "title": "シフトマネージャーアカウントとの連携",
              "text": "※連携後は連携解除ボタンからもしくはブロックすることでいつでも連携を解除することができます",
              "actions": [
                {
                  "type": "uri",
                  "label": "アカウントを連携する",
                  "uri": "#{ENV['NGROK_URL']}/users/line_connections/new?linkToken=#{link_token}"
                }
              ]
            }
          }
        ]
      }.to_json
      res = http.request(req)
    end
  end
end
