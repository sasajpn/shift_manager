require 'net/https'

module Line
  class RegistShiftSubmissionService
    def initialize(reply_token, line_user_id)
      @reply_token = reply_token
      @line_user_id = line_user_id
    end

    def regist
      request_regist
    end

    private

    attr_reader :reply_token, :line_user_id

    def get_start_time
      Redis.current.hget(line_user_id, 'start_time')
    end

    def get_end_time
      Redis.current.hget(line_user_id, 'end_time')
    end

    def request_regist_error_message
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
            "text": "過去のメッセージからシフトの希望が提出されています\nシフト希望の提出をやり直してください"
          }
        ]
      }.to_json
      res = http.request(req)
    end

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
    end
  end
end
