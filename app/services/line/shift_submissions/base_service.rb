module Line
  module ShiftSubmissions
    class BaseService < Line::BaseService
      attr_accessor :reply_token, :line_user_id, :start_time, :end_time

      def initialize(attributes = nil)
        attributes.each do |key, value|
          public_send("#{key}=", value) if respond_to?("#{key}=")
        end
      end

      private

      attr_reader :reply_token, :line_user_id, :start_time, :end_time

      def get_line_connection
        LineConnection.find_by(line_user_id: line_user_id)
      end

      def set_before_action(action)
        Redis.current.hset(line_user_id, 'before_action', action)
      end

      def get_before_action
        Redis.current.hget(line_user_id, 'before_action')
      end

      def set_start_time
        Redis.current.hset(line_user_id, 'start_time', start_time)
      end

      def set_end_time
        Redis.current.hset(line_user_id, 'end_time', end_time)
      end

      def get_start_time
        Redis.current.hget(line_user_id, 'start_time')
      end

      def get_end_time
        Redis.current.hget(line_user_id, 'end_time')
      end

      def delete_start_time
        Redis.current.del(line_user_id, 'start_time')
      end

      def delete_end_time
        Redis.current.del(line_user_id, 'end_time')
      end

      def request_invalid_action_message
        body = {
          "replyToken": "#{reply_token}",
          "messages": [
            {
              "type": "text",
              "text": "シフト希望のリクエストが順番通りに行われていません。\nシフト希望の提出をやり直してください"
            }
          ]
        }.to_json
        reply_message(body)
      end
    end
  end
end
