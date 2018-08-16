class Users::Managers::ShiftRegistrationsController < Users::ApplicationController
  before_action :set_shift_registration, only: [:edit]
  before_action :set_member, only: [:new]
  before_action :set_team, only: [:new, :edit]

  include Users::Managers::AccessControl
  before_action :check_valid_permisson, only: [:new, :edit]

  def new
  end

  def edit
    @member = @shift_registration.member
  end

  private

  def set_shift_registration
    @shift_registration = Shift::Registration.find_by(id: params[:id])
  end

  def set_team
    @team = @member&.team || @shift_registration&.team
  end
end
