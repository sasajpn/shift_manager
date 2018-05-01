require 'net/https'

module Line
  class UpdateRichmenuService
    def initialize(line_connection)
      @line_connection = line_connection
    end

    def update
      request_unlink_richmenu
      request_link_richmenu
    end

    private

    attr_reader :line_connection

    def request_unlink_richmenu
      uri = URI.parse("https://api.line.me/v2/bot/user/#{line_connection.line_user_id}/richmenu")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      res = http.request(req)
    end

    def request_link_richmenu
      uri = URI.parse("https://api.line.me/v2/bot/user/#{line_connection.line_user_id}/richmenu/richmenu-4735897f0f66811b1863cc2b2d709fb3")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      res = http.request(req)
    end
  end
end
