require 'net/https'

module Line
  class UnlinkRichmenuService
    def initialize(line_user_id)
      @line_user_id = line_user_id
    end

    def unlink
      request_unlink_richmenu
    end

    private

    attr_reader :line_user_id

    def request_unlink_richmenu
      uri = URI.parse("https://api.line.me/v2/bot/user/#{line_user_id}/richmenu")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      res = http.request(req)
    end
  end
end
