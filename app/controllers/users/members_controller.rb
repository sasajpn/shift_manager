class Users::MembersController < Users::ApplicationController
  before_action :set_member, only: [:edit, :update]

  def new
    @member = JoinTeamForm.new
  end

  def create
    @member = JoinTeamForm.new(join_team_form_params)
    if @member.save(current_user)
      redirect_to users_teams_url
    else
      render :new
    end
  end

  def edit
    @team = @member.team
  end

  def update
    if @member.update(member_params)
      redirect_to users_team_url(@member.team)
    else
      @team = @member.team
      render :edit end
  end

  def destroy
  end

  private

  def join_team_form_params
    params.require(:join_team_form).permit(:identifier)
  end

  def member_params
    params.fetch(:member, {}).permit(
      :calendar_color
    )
  end

  def set_member
    @member = Member.find(params[:id])
  end

end
