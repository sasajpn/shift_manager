module Line
  module Accounts
    class CreateConnectionService < Line::BaseService

      def create
        account = get_account
        create_connection(account)
      end

    private

      def get_account
        account_type = Redis.current.hget(nonce, 'type')
        account_id = Redis.current.hget(nonce, 'id')
        account_type.constantize.find(account_id)
      end

      def create_connection(account)
        account.create_line_connection(nonce: nonce, line_user_id: line_user_id)
      end

    end
  end
end
