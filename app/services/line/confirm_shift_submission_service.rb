require 'net/https'

module Line
  class ConfirmShiftSubmissionService
    def initialize(reply_token, line_user_id)
      @reply_token = reply_token
      @line_user_id = line_user_id
    end

    def confirm
      start_time = get_start_time&.to_time
      end_time = get_end_time&.to_time
      if start_time && end_time
        if start_time <= end_time
          request_confirm_message(start_time, end_time)
        else
          request_time_order_error_message
        end
      else
        request_blank_error_message
      end
    end

    private

    attr_reader :reply_token, :line_user_id

    def get_start_time
      Redis.current.hget(line_user_id, 'start_time')
    end

    def get_end_time
      Redis.current.hget(line_user_id, 'end_time')
    end

    def request_time_order_error_message
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
            "text": "開始時間が終了時間を超えています\nシフト希望の提出をやり直してください"
          }
        ]
      }.to_json
      res = http.request(req)
    end

    def request_blank_error_message
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
            "text": "開始時間あるいは終了時間が選択されていません\nシフト希望の提出をやり直してください"
          }
        ]
      }.to_json
      res = http.request(req)
    end

    def request_confirm_message(start_time, end_time)
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
              "text": "#{start_time.to_time.strftime('%Y年%m月%d日%H:%M')}~#{end_time.to_time.strftime('%Y年%m月%d日%H:%M')}でシフトの希望を提出しますか？",
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
