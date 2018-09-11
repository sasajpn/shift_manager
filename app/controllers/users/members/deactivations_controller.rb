class Users::Members::DeactivationsController < Users::ApplicationController
  before_action :set_member

  include Users::AccessControl
  before_action :check_valid_permisson

  def show

  end

  def destroy
    if @member.destroy
      redirect_to users_members_url, notice: 'チームを脱退しました。'
    else
      redirect_to users_home_index_url, alert: '未来に調整されたシフト、もしくは登録されたシフトが残っているためチームを脱退できません。'
    end
  end

  private

  def have_valid_permission?
    @member.user == current_user
  end
end
