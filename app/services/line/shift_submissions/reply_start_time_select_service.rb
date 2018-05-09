module Line
  module ShiftSubmissions
    class ReplyStartTimeSelectService < Line::ShiftSubmissions::BaseService

      def reply
        if get_before_action == 'shift_submission'
          set_before_action('shift_submission[team]')
          set_team_id
          request_start_time_select
        else
          request_invalid_action_message
        end
      end

      private

      def request_start_time_select
        team = Team.find(team_id)
        time = Time.current
        body = [
          {
            type: 'template',
            altText: 'This is a buttons template',
            template: {
              type: 'buttons',
              title: 'シフト希望の提出',
              text: "提出先は#{team.name}です\n希望の開始日時を選択してください",
              actions: [
                type: 'datetimepicker',
                label: 'タップしてください',
                data: 'shift_submission[start_time]',
                mode: 'datetime',
                initial: line_time_format(time),
                max: line_time_format(time.next_year),
                min: line_time_format(time)
              ]
            }
          }
        ]
        reply_message(body)
      end
    end
  end
end
