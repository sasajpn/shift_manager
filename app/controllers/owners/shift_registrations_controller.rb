class Owners::ShiftRegistrationsController < Owners::ApplicationController
  before_action :set_member, only: [:new]
  before_action :set_team, only: [:new]

  def new
  end

  def edit
  end

  private

  def set_member
    @member = Member.find(params[:member_id])
  end

  def set_team
    super
    @team ||= @member.team
  end
end
