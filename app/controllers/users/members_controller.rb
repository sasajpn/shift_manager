class Users::MembersController < Users::ApplicationController
  before_action :set_member, only: [:edit, :update]

  def edit
    @team = @member.team
  end

  def update
    if @member.update(member_params)
      redirect_to users_team_url(@member.team)
    else
      @team = @member.team
      render :edit
    end
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

end
