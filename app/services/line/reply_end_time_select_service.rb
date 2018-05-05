require 'net/https'

module Line
  class ReplyEndTimeSelectService
    def initialize(reply_token, start_time)
      @reply_token = reply_token
      @start_time = start_time
    end

    def reply
      request_end_time_select
    end

    private

    attr_reader :reply_token, :start_time

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
