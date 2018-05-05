require 'net/https'

module Line
  class LinkConnectedRichmenuService
    def initialize(reply_token, line_user_id)
      @reply_token = reply_token
      @line_user_id = line_user_id
    end

    def link
      request_unlink_unconnected_richmenu
      get_connected_richmenus.each do |richmenu|
        request_link_connected_richmenu(richmenu.richmenu_id)
      end
    end

    private

    attr_reader :reply_token, :line_user_id

    def get_connected_richmenus
      LineConnectedRichmenu.all
    end

    def request_unlink_unconnected_richmenu
      uri = URI.parse("https://api.line.me/v2/bot/user/#{line_user_id}/richmenu")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      res = http.request(req)
    end

    def request_link_connected_richmenu(richmenu_id)
      uri = URI.parse("https://api.line.me/v2/bot/user/#{line_user_id}/richmenu/#{richmenu_id}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      res = http.request(req)
    end
  end
end
