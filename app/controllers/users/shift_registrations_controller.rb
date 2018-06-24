class Users::ShiftRegistrationsController < Users::ApplicationController
  before_action :set_shift_registration, only: [:edit]
  before_action :set_member, only: [:new, :edit]
  before_action -> { authorize! @member }

  def new
    @team = @member.team
  end

  def edit
    @team = @member.team
  end

  private

  def set_shift_registration
    @shift_registration = Shift::Registration.find_by(id: params[:id])
  end

  def set_member
    @member = Member.find_by(id: params[:member_id]) || @shift_registration.member
  end
end
