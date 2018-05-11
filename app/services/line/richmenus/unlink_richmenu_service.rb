module Line
  module Richmenus
    class UnlinkRichmenuService < Line::BaseService

      def unlink
        request_unlink_richmenu
      end

      private

      def request_unlink_richmenu
        post(path: "user/#{line_user_id}/richmenu")
      end

    end
  end
end
