require 'net/https'

module Line
  class ConfirmDestroyableConnectionService
    def initialize(reply_token)
      @reply_token = reply_token
    end

    def confirm
      message_confirm_destroyable_connection
    end

    private

    attr_reader :reply_token

    def message_confirm_destroyable_connection
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
            "altText": "This is a confirm template",
            "template": {
              "type": "confirm",
              "text": "アカウントの連携を解除しますか？",
              "actions": [
                {
                  "type": "postback",
                  "label": "はい",
                  "data": "destroy_connection[OK]"
                },
                {
                  "type": "postback",
                  "label": "いいえ",
                  "data": "destroy_connection[NG]"
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
