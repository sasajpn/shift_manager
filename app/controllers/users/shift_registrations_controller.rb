class Users::ShiftRegistrationsController < Users::ApplicationController
  before_action :set_shift_registration, only: [:show]
  before_action :set_member, only: [:show]

  include Users::AccessControl

  def show
  end

  def set_shift_registration
    @shift_registration = Shift::Registration.find_by(id: params[:id])
  end

  def set_member
    @member = @shift_registration.member
  end
end
