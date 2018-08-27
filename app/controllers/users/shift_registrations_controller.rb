class Users::ShiftRegistrationsController < Users::ApplicationController
  before_action :set_shift_registration, only: [:show]
  before_action :set_member, only: [:show]

  include Users::AccessControl
  before_action :check_valid_permisson, only: [:show]

  def show
  end

  private

  def have_valid_permission?
    @member.user == current_user
  end

  def set_shift_registration
    @shift_registration = Shift::Registration.find_by(id: params[:id])
  end

  def set_member
    @member = @shift_registration.member
  end
end
