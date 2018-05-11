module Line
  module ShiftSubmissions
    class RegistShiftSubmissionService < Line::ShiftSubmissions::BaseService

      def regist
        if get_before_action == 'shift_submission[end_time]'
          team_id = get_team_id
          puts team_id
          start_time = get_start_time
          end_time = get_end_time
          if account = get_line_connection&.account
            member = account.members.find_by(team_id: team_id)
            shift_submission = member.shift_submissions.build(
              submitted_date: start_time&.to_date,
              start_time: start_time&.strftime('%H:%M'),
              end_time: end_time&.strftime('%H:%M')
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
        data = [
          {
            type: 'text',
            text: 'シフト希望を提出しました。'
          }
        ]
        post(data: data)
      end

      def request_error_message(error_messages)
        data = [
          {
            type: 'text',
            text: "#{error_messages.join("\n")}\nもう一度やり直してください。"
          }
        ]
        post(data: data)
      end

    end
  end
end
