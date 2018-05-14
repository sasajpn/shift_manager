class Users::ShiftCoordinators::ShiftSubmissionsController < Users::ApplicationController
  before_action :set_member, only: [:new]

  def new
    @team = @member.team
  end

  def destroy
  end

  private

  def set_member
    @member = Member.find(params[:member_id])
  end
end
