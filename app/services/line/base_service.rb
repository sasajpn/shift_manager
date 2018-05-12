require 'net/http'
require 'uri'

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

    def http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
        if uri.scheme == "https"
          http.use_ssl = true
        end

        http
    end

    def header
      {
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      }
    end

    def payload(data)
      payload = {
        replyToken: "#{reply_token}",
        messages: data
      }

      payload.delete_if{|k, v| v.nil?}.to_json
    end

    def post(path: 'message/reply', data: '')
      uri = URI.parse(LINE_API_ENDPOINT + path)
      http(uri).post(uri.request_uri, payload(data), header)
    end

  end
end
