module Owners
  module AccessControl
    extend ActiveSupport::Concern

    included do
      before_action :check_valid_permisson, only: [:edit, :update, :destroy]
    end

    def check_valid_permisson
      unless have_valid_permission?
        flash[:error] = 'リクエストされたページへのアクセス権限がありません'
        return redirect_to owners_home_index_url
      end
    end

    def have_valid_permission?
      team.owner == current_owner
    end

    def team
      if controller_name == 'teams'
        eval "@#{controller_name.singularize}"
      else
        eval "@#{controller_name.singularize}&.team"
      end
    end
  end
end
