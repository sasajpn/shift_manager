module Line
  module ShiftSubmissions
    class ReplyStartTimeSelectService < Line::ShiftSubmissions::BaseService

      def reply
        delete_start_time
        delete_end_time
        set_before_action('shift_submission')
        request_start_time_select
      end

      private

      def request_start_time_select
        time = Time.current
        body = {
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
                    "initial": line_time_format(time),
                    "max": line_time_format(time.next_year),
                    "min": line_time_format(time)
                  }
                ]
              }
            }
          ]
        }.to_json
        reply_message(body)
      end
    end
  end
end
