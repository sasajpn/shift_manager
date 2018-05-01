require 'net/https'

module Line
  class ReplyStartTimeSelectService
    def initialize(reply_token)
      @reply_token = reply_token
    end

    def reply
      request_start_time_select
    end

    private

    attr_reader :reply_token

    def request_start_time_select
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
              "text": "希望の開始日時を選択してください",
              "actions": [
                {
                  "type": "datetimepicker",
                  "label": "タップしてください",
                  "data": "shift_submission[start_time]",
                  "mode": "datetime",
                  "initial": Time.current.strftime('%Y-%m-%dt%H:%M'),
                  "max": Time.current.next_year.strftime('%Y-%m-%dt%H:%M'),
                  "min": Time.current.strftime('%Y-%m-%dt%H:%M')
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
