module Line
  module ShiftSubmissions
    class CancelShiftSubmissionService < Line::ShiftSubmissions::BaseService

      def cancel
        if get_before_action == 'shift_submission[end_time]'
          delete_start_time
          delete_end_time
          set_before_action('shift_submission[confirm]')
          request_cancel_message
        else
          request_invalid_action_message
        end
      end

      private

      def request_cancel_message
        data = [
          {
            type: 'text',
            text: 'シフト希望の提出を取り消しました。'
          }
        ]
        post(data: data)
      end

    end
  end
end
