require 'net/https'

module Line
  class BaseService
    attr_accessor :reply_token, :line_user_id, :start_time, :end_time, :team_id

    def initialize(attributes = nil)
      attributes.each do |key, value|
        public_send("#{key}=", value) if respond_to?("#{key}=")
      end
    end

    private

    attr_reader :reply_token, :line_user_id, :start_time, :end_time, :team_id

    def header(req)
      req["Content-Type"] = "application/json"
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
    end

    def payload(req, body)
      req.body = {
        replyToken: "#{reply_token}",
        messages: body
      }.to_json
    end

    def reply_message(body)
      uri = URI.parse("https://api.line.me/v2/bot/message/reply")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      header(req)
      payload(req, body)
      res = http.request(req)
    end
  end
end
