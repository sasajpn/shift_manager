require 'net/https'

module Line
  class CreateLinkTokenService
    def initialize(line_user_id)
      @line_user_id = line_user_id
    end

    def create
      link_token = request_link_token
    end

    private

    attr_reader :line_user_id

    def request_link_token
      uri = URI.parse("https://api.line.me/v2/bot/user/#{line_user_id}/linkToken")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      res = http.request(req)
      ActiveSupport::JSON.decode(res.body)['linkToken']
    end
  end
end
