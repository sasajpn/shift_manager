module Line
  module ShiftSubmissions
    class ReplyEndTimeSelectService < Line::ShiftSubmissions::BaseService

      def reply
        if get_before_action == 'shift_submission'
          set_before_action('shift_submission[start_time]')
          set_start_time
          request_end_time_select
        else
          request_invalid_action_message
        end
      end

      private

      def request_end_time_select
        body = {
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
        reply_message(body)
      end
    end
  end
end
