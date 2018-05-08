require 'net/https'

module Line
  class ReplyEndTimeSelectService
    def initialize(reply_token, line_user_id, start_time)
      @reply_token = reply_token
      @line_user_id = line_user_id
      @start_time = start_time
    end

    def reply
      if get_before_action == 'shift_submission'
        set_before_action
        set_start_time
        request_end_time_select
      else
        request_invalid_action_message
      end
    end

    private

    attr_reader :reply_token, :line_user_id, :start_time

    def get_before_action
      Redis.current.hget(line_user_id, 'before_action')
    end

    def set_before_action
      Redis.current.hset(line_user_id, 'before_action', 'shift_submission[start_time]')
    end

    def set_start_time
      Redis.current.hset(line_user_id, 'start_time', start_time)
    end

    def request_invalid_action_message
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
            "text": "シフト希望のリクエストが順番通りに行われていません。\nシフト希望の提出をやり直してください"
          }
        ]
      }.to_json
      res = http.request(req)
    end

    def request_end_time_select
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
            "altText": "This is a buttons template",
            "template": {
              "type": "buttons",
              "title": "シフト希望の提出",
              "text": "開始時間は#{start_time.to_time.strftime('%Y年%m月%d日 %H:%M')}です\n希望の終了日時を選択してください",
              "actions": [
                {
                  "type": "datetimepicker",
                  "label": "タップしてください",
                  "data": "shift_submission[end_time]",
                  "mode": "datetime",
                  "initial": start_time,
                  "max": start_time.to_time.tomorrow.strftime('%Y-%m-%dt%H:%M'),
                  "min": start_time
                },
              ]
            }
          }
        ]
      }.to_json
      res = http.request(req)
    end
  end
end
