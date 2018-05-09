require 'net/https'

module Line
  class BaseService
    LINE_API_ENDPOINT = 'https://api.line.me/v2/bot/'

    attr_accessor :reply_token, :line_user_id, :start_time, :end_time, :team_id, :nonce

    def initialize(attributes = nil)
      attributes.each do |key, value|
        public_send("#{key}=", value) if respond_to?("#{key}=")
      end
    end

    private

    attr_reader :reply_token, :line_user_id, :start_time, :end_time, :team_id, :nonce

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

    def reply_message(body = '', path = 'message/reply')
      uri = URI.parse(LINE_API_ENDPOINT + path)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      header(req)
      payload(req, body)
      http.request(req)
    end

  end
end
