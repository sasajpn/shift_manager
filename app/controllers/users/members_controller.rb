class Users::MembersController < Users::ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: [:index, :show, :edit, :update]
  before_action :set_current_member, only: [:index, :show, :edit]
  before_action -> { authorize! @current_member }

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @member.update(member_params)
      redirect_to users_team_url(@member.team)
    else
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
    super
    @team ||= @member.team
  end
end
