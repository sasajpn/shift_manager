class Users::ShiftCoordinators::MembersController < Users::ApplicationController
  before_action :set_team, only: [:index]
  before_action :set_member, only: [:show]
  before_action :set_current_member, only: [:index]

  def index
    @members = @team.members.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

end
