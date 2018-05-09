module Line
  module ShiftSubmissions
    class ReplyEndTimeSelectService < Line::ShiftSubmissions::BaseService

      def reply
        if get_before_action == 'shift_submission[team]'
          set_before_action('shift_submission[start_time]')
          set_start_time
          request_end_time_select
        else
          request_invalid_action_message
        end
      end

      private

      def request_end_time_select
        body = [
          {
            type: 'template',
            altText: 'This is a buttons template',
            template: {
              type: 'buttons',
              title: 'シフト希望の提出',
              text: "開始時間は#{japanese_time_format(start_time)}です\n希望の終了日時を選択してください",
              actions: [
                type: 'datetimepicker',
                label: 'タップしてください',
                data: 'shift_submission[end_time]',
                mode: 'datetime',
                initial: line_time_format(start_time.since(1.minutes)),
                max: line_time_format(start_time.tomorrow),
                min: line_time_format(start_time.since(1.minutes))
              ]
            }
          }
        ]
        reply_message(body)
      end
    end
  end
end
