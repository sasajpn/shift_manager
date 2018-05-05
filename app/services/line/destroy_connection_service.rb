require 'net/https'

module Line
  class DestroyConnectionService
    def initialize(line_user_id)
      @line_user_id = line_user_id
    end

    def destroy
      line_connection = get_line_connection
      if line_connection
        destroy_connection(line_connection)
      end
    end

    private

    attr_reader :line_user_id

    def get_line_connection
      LineConnection.find_by(line_user_id: line_user_id)
    end

    def destroy_connection(line_connection)
      line_connection.destroy
    end
  end
end
