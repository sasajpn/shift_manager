module Owners
  module AccessControl
    extend ActiveSupport::Concern

    def check_valid_permisson
      unless have_valid_permission?
        flash[:error] = 'リクエストされたページへのアクセス権限がありません'
        return redirect_to owners_home_index_url
      end
    end

    private

    def have_valid_permission?
      if controller_name == 'teams' || ['index', 'new', 'create'].include?(action_name)
        @team.owner == current_owner
      else
        (eval "@#{controller_name.singularize}.team_owner") == current_owner
      end
    end
  end
end
