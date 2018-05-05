module Line
  class StoreStartTimeService
    def initialize(reply_token, line_user_id, start_time)
      @reply_token = reply_token
      @line_user_id = line_user_id
      @start_time = start_time
    end

    def store
      set_start_time
    end

    private

    attr_reader :reply_token, :line_user_id, :start_time

    def set_start_time
      Redis.current.hset(line_user_id, 'start_time', start_time)
    end
  end
end
