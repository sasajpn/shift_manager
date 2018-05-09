module Line
  module ShiftSubmissions
    class ConfirmShiftSubmissionService < Line::ShiftSubmissions::BaseService

      def confirm
        start_time = get_start_time
        if get_before_action == 'shift_submission[start_time]'
          if start_time < end_time
            set_end_time
            set_before_action('shift_submission[end_time]')
            request_confirm_message(start_time, end_time)
          else
            request_time_order_error_message
          end
        else
          request_invalid_action_message
        end
      end

      private

      def request_time_order_error_message
        body = {
          "replyToken": "#{reply_token}",
          "messages": [
            {
              "type": "text",
              "text": "開始時間が終了時間を超えています\nシフト希望の提出をやり直してください"
            }
          ]
        }.to_json
        reply_message(body)
      end

      def request_blank_error_message
        body = {
          "replyToken": "#{reply_token}",
          "messages": [
            {
              "type": "text",
              "text": "開始時間あるいは終了時間が選択されていません\nシフト希望の提出をやり直してください"
            }
          ]
        }.to_json
        reply_message(body)
      end

      def request_confirm_message(start_time, end_time)
        body = {
          "replyToken": "#{reply_token}",
          "messages": [
            {
              "type": "template",
              "altText": "This is a confirm template",
              "template": {
                "type": "confirm",
                "text": "#{japanese_time_format(start_time)}~#{japanese_time_format(end_time)}でシフトの希望を提出しますか？",
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
        reply_message(body)
      end
    end
  end
end
