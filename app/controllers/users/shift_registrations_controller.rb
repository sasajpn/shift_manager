class Users::ShiftRegistrationsController < Users::ApplicationController
  before_action :set_shift_registration, only: [:edit]
  before_action :set_member, only: [:new]

  def new
    @team = @member.team
  end

  def edit
    @member = @shift_registration.member
    @team = @member.team
  end

  private

  def set_shift_registration
    @shift_registration = Shift::Registration.find(params[:id])
  end

  def set_member
    @member = Member.find(params[:member_id])
  end
end
