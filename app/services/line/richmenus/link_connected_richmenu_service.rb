module Line
  module Richmenus
    class LinkConnectedRichmenuService < Line::BaseService

      def link
        request_unlink_unconnected_richmenu
        get_connected_richmenus.each do |richmenu|
          request_link_connected_richmenu(richmenu.richmenu_id)
        end
      end

      private

      def get_connected_richmenus
        LineConnectedRichmenu.all
      end

      def request_unlink_unconnected_richmenu
        reply_message(body, "user/#{line_user_id}/richmenu")
      end

      def request_link_connected_richmenu(richmenu_id)
        reply_message(body, "user/#{line_user_id}/richmenu/#{richmenu_id}")
      end

    end
  end
end
