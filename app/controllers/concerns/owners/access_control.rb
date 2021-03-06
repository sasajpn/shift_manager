module Owners
  module AccessControl
    extend ActiveSupport::Concern

    included do
      before_action :check_valid_permisson
    end

    def check_valid_permisson
      unless have_valid_permission?
        flash[:error] = 'リクエストされたページへのアクセス権限がありません'
        return redirect_to owners_home_index_url
      end
    end

    private

    def access_team
      @team || (eval "@#{controller_name.singularize}.team")
    end

    def have_valid_permission?
      access_team.owner == current_owner && access_team.active?
    end
  end
end
