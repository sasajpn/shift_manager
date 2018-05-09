module Line
  module ShiftSubmissions
    class RegistShiftSubmissionService < Line::ShiftSubmissions::BaseService

      def regist
        if get_before_action == 'shift_submission[end_time]'
          start_time = get_start_time&.to_time
          end_time = get_end_time&.to_time
          if account = get_line_connection&.account
            member = account.members.first
            shift_submission = member.shift_submissions.build(
              submitted_date: start_time.to_date, start_time: start_time.strftime('%H:%M'), end_time: end_time.strftime('%H:%M')
            )
            if shift_submission.save
              set_before_action('shift_submission[confirm]')
              request_success_message
            else
              request_error_message(shift_submission.errors.full_messages)
            end
          end
        else
          request_invalid_action_message
        end
      end

      private

      def request_success_message
        body = {
          "replyToken": "#{reply_token}",
          "messages": [
            {
              "type": "text",
              "text": "シフト希望を提出しました。"
            }
          ]
        }.to_json
        reply_message(body)
      end

      def request_error_message(error_messages)
        body = {
          "replyToken": "#{reply_token}",
          "messages": [
            {
              "type": "text",
              "text": "#{error_messages}"
            }
          ]
        }.to_json
        reply_message(body)
      end

    end
  end
end
