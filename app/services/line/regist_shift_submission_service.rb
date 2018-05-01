require 'net/https'

module Line
  class RegistShiftSubmissionService
    def initialize(reply_token, start_time, end_time)
      @reply_token = reply_token
      @start_time = start_time
      @end_time = end_time
    end

    def regist
      request_regist
    end

    private

    attr_reader :reply_token, :start_time, :end_time

    def request_regist
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
            "text": "シフト希望を提出しました。"
          }
        ]
      }.to_json
      res = http.request(req)
      puts res.body
    end
  end
end
