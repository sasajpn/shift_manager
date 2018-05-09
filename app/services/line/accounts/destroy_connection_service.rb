require 'net/https'

module Line
  class DestroyConnectionService
    def initialize(reply_token, line_user_id)
      @reply_token = reply_token
      @line_user_id = line_user_id
    end

    def destroy
      line_connection = get_line_connection
      if line_connection
        destroy_connection(line_connection)
      end
      message_destroyed_connection
    end

    private

    attr_reader :reply_token, :line_user_id

    def get_line_connection
      LineConnection.find_by(line_user_id: line_user_id)
    end

    def destroy_connection(line_connection)
      line_connection.destroy
    end

    def message_destroyed_connection
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
            "text": "アカウントの連携を解除しました"
          }
        ]
      }.to_json
      res = http.request(req)
    end
  end
end
