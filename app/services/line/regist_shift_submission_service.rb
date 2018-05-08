require 'net/https'

module Line
  class RegistShiftSubmissionService
    def initialize(reply_token, line_user_id)
      @reply_token = reply_token
      @line_user_id = line_user_id
    end

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
            set_before_action
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

    attr_reader :reply_token, :line_user_id

    def get_line_connection
      LineConnection.find_by(line_user_id: line_user_id)
    end

    def get_start_time
      Redis.current.hget(line_user_id, 'start_time')
    end

    def get_end_time
      Redis.current.hget(line_user_id, 'end_time')
    end

    def get_before_action
      Redis.current.hget(line_user_id, 'before_action')
    end

    def set_before_action
      Redis.current.hset(line_user_id, 'before_action', 'shift_submission[confirm]')
    end

    def request_invalid_action_message
      uri = URI.parse("https://api.line.me/v2/bot/message/reply")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Content-Type"] = "application/json"
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      req.body = {
        "replyToken": "#{reply_token}",
        "messages": [
          {
            "type": "text",
            "text": "シフト希望のリクエストが順番通りに行われていません。\nシフト希望の提出をやり直してください"
          }
        ]
      }.to_json
      res = http.request(req)
    end

    def request_success_message
      uri = URI.parse("https://api.line.me/v2/bot/message/reply")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Content-Type"] = "application/json"
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      req.body = {
        "replyToken": "#{reply_token}",
        "messages": [
          {
            "type": "text",
            "text": "シフト希望を提出しました。"
          }
        ]
      }.to_json
      res = http.request(req)
    end

    def request_error_message(error_messages)
      uri = URI.parse("https://api.line.me/v2/bot/message/reply")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Content-Type"] = "application/json"
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      req.body = {
        "replyToken": "#{reply_token}",
        "messages": [
          {
            "type": "text",
            "text": "#{error_messages}"
          }
        ]
      }.to_json
      res = http.request(req)
    end
  end
end
