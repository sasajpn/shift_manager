class Users::ShiftCoordinators::TeamsController < Users::ApplicationController
  before_action :set_team, only: [:show, :update_identifier]
  before_action :set_member, only: [:show, :update_identifier]

  include Users::ShiftCoordinators::AccessControl
  before_action :check_valid_permisson, except: [:update_identifier]

  def show
    @members = @team.members.access_members(@member.role).order(created_at: :desc).page(params[:page]).per(15)
    @unapprovals = @team.members.unapprovals
  end

  def update_identifier
    authorize! @team
    if @team.update(identifier: SecureRandom.hex(5))
      redirect_to users_shift_coordinators_team_url(@team), flash: { success: 'チームの認証コードを更新しました' }
    else
      render :show
    end
  end

  private

  def set_team
    @team = Team.find_by(id: params[:id])
  end

  def set_member
    @member = @team.member(current_user)
  end
end
