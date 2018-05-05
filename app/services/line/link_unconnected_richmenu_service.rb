require 'net/https'

module Line
  class LinkUnconnectedRichmenuService
    def initialize(line_user_id)
      @line_user_id = line_user_id
    end

    def link
      get_unconnected_richmenus.each do |richmenu|
        request_link_unconnected_richmenu(richmenu.richmenu_id)
      end
    end

    private

    attr_reader :line_user_id

    def get_unconnected_richmenus
      LineUnconnectedRichmenu.all
    end

    def request_link_unconnected_richmenu(richmenu_id)
      uri = URI.parse("https://api.line.me/v2/bot/user/#{line_user_id}/richmenu/#{richmenu_id}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req["Authorization"] = "Bearer #{ENV["LINE_CHANNEL_TOKEN"]}"
      res = http.request(req)
    end
  end
end