class Users::ShiftCoordinators::ShiftRegistrationsController < Users::ApplicationController
  before_action :set_shift_registration, only: [:edit, :destroy]
  before_action :set_member, only: [:new, :edit, :destroy]
  before_action :set_team, only: [:new, :edit, :destroy]

  include Users::ShiftCoordinators::AccessControl

  def new
  end

  def edit
  end

  def destroy
    @shift_registration.destroy
    redirect_to users_shift_coordinators_member_url(@shift_registration.member)
  end

  private

  def set_shift_registration
    @shift_registration = Shift::Registration.find_by(id: params[:id])
  end

  def set_member
    super
    @member ||= @shift_registration.member
  end

  def set_team
    @team = @member&.team || @shift_registration&.team
  end
end
