class Owners::MembersController < Owners::ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: [:index, :new, :create]

  def index
    @members = @team.members.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @shift_submissions = @member.shift_submissions.non_approved.order(submitted_date: :desc).page(params[:page]).per(15)
  end

  def edit
  end

  def update
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
