require 'net/https'

module Line
  class CancelDestroyedConnectionService
    def initialize(reply_token)
      @reply_token = reply_token
    end

    def cancel
      message_cancel_destroyed_connection
    end

    private

    attr_reader :reply_token

    def message_cancel_destroyed_connection
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
            "type": "text",
            "text": "アカウントの連携解除をキャンセルしました"
          }
        ]
      }.to_json
      res = http.request(req)
    end
  end
end
