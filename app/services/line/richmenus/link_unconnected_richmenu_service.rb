module Line
  module Richmenus
    class LinkUnconnectedRichmenuService < Line::BaseService

      def link
        get_unconnected_richmenus.each do |richmenu|
          request_link_unconnected_richmenu(richmenu.richmenu_id)
        end
      end

      private

      def get_unconnected_richmenus
        LineUnconnectedRichmenu.all
      end

      def request_link_unconnected_richmenu(richmenu_id)
        reply_message('', "user/#{line_user_id}/richmenu/#{richmenu_id}")
      end

    end
  end
end
