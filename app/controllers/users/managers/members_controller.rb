class Users::Managers::MembersController < Users::ApplicationController
  before_action :set_member, only: [:show, :edit, :destroy]
  before_action :set_team, only: [:index]

  def index
    @members = @team.members.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
  end

  def edit
  end

  def destroy
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end