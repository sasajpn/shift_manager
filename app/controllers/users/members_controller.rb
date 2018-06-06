class Users::MembersController < Users::ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: [:index]

  def show
  end

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

  def set_team
    @team = Team.find(params[:team_id])
  end
end
