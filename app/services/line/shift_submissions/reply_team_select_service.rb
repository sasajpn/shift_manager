module Line
  module ShiftSubmissions
    class ReplyTeamSelectService < Line::ShiftSubmissions::BaseService

      def reply

      end

      private

      def request_team_select
        body = {
          "replyToken": "#{reply_token}",
          "messages": [
            {
              "type": "template",
              "altText": "This is a buttons template",
              "template": {
                "type": "buttons",
                "title": "シフト希望の提出",
                "text": "開始時間は#{japanese_time_format(start_time)}です\n希望の終了日時を選択してください",
                "actions": [
                  {
                    "type": "message",
                    "label": "タップしてください",
                    "data": "shift_submission[end_time]",
                    "mode": "datetime",
                    "initial": line_time_format(start_time.since(1.minutes)),
                    "max": line_time_format(start_time.tomorrow),
                    "min": line_time_format(start_time.since(1.minutes))
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
