class Users::MembersController < Users::ApplicationController
  before_action :set_member, only: [:show, :edit, :destroy]
  before_action :set_team, only: [:index, :show, :edit]
  before_action :set_current_member, only: [:index, :show]

  include Users::AccessControl
  before_action :check_valid_permisson, only: [:edit]

  def edit
  end

  def destroy
  end

  private

  def member_params
    params.fetch(:member, {}).permit(
      :calendar_color
    )
  end

  def set_member
    @member = Member.find(params[:id])
  end

  def set_team
    super
    @team ||= @member.team
  end
end
