class Owners::MembersController < Owners::ApplicationController
  before_action :set_member, only: [:show, :edit, :destroy]
  before_action :set_team, only: [:index, :new, :create]

  def index
    @members = @team.members.approvals.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @shift_submissions = @member.shift_submissions.unapprovals.order(submitted_date: :desc).page(params[:page]).per(15)
  end

  def edit
  end

  def destroy
    @member.destroy
    redirect_to owners_team_members_url(@member.team)
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
