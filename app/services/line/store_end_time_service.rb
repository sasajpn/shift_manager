module Line
  class StoreEndTimeService
    def initialize(line_user_id, end_time)
      @line_user_id = line_user_id
      @end_time = end_time
    end

    def store
      set_end_time
    end

    private

    attr_reader :line_user_id, :end_time

    def set_end_time
      Redis.current.hset(line_user_id, 'end_time', end_time)
    end
  end
end
