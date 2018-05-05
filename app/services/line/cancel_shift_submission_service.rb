require 'net/https'

module Line
  class CancelShiftSubmissionService
    def initialize(reply_token, line_user_id)
      @reply_token = reply_token
      @line_user_id = line_user_id
    end

    def cancel
      delete_start_time
      delete_end_time
      request_cancel_message
    end

    private

    attr_reader :reply_token, :line_user_id

    def delete_start_time
      Redis.current.del(line_user_id, 'start_time')
    end

    def delete_end_time
      Redis.current.del(line_user_id, 'end_time')
    end

    def request_cancel_message
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
            "text": "シフト希望の提出を取り消しました。"
          }
        ]
      }.to_json
      res = http.request(req)
    end
  end
end
