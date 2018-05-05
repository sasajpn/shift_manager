require 'net/https'

module Line
  class ConfirmShiftSubmissionService
    def initialize(reply_token, start_time, end_time)
      @reply_token = reply_token
      @start_time = start_time
      @end_time = end_time
    end

    def confirm
      if start_time.to_time <= end_time.to_time
        request_confirm_message
      else
        request_error_message
      end
    end

    private

    attr_reader :reply_token, :start_time, :end_time

    def request_error_message
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
            "text": "開始時間が終了時間を超えています\nもう一度シフト希望の提出を行ってください"
          }
        ]
      }.to_json
      res = http.request(req)
    end

    def request_confirm_message
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
              "text": "#{start_time.to_time.strftime('%Y年%m月%d日%H:%M')}~#{end_time.to_time.strftime('%Y年%m月%d日%H:%M')}で希望を提出しますか？",
              "actions": [
                {
                  "type": "postback",
                  "label": "はい",
                  "data": "shift_submission[regist]"
                },
                {
                  "type": "postback",
                  "label": "いいえ",
                  "data": "shift_submission[cancel]"
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
