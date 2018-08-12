class Owners::ShiftRegistrationsController < Owners::ApplicationController
  before_action :set_shift_registration, only: [:edit]
  before_action :set_member, only: [:new, :edit]
  before_action :set_team, only: [:new, :edit]

  include Owners::AccessControl
  before_action :check_valid_permisson, only: [:new]

  def new
  end

  def edit
  end

  private

  def set_shift_registration
    @shift_registration = Shift::Registration.find(params[:id])
  end

  def set_member
    super
    @member ||= @shift_registration.member
  end

  def set_team
    super
    @team ||= @member&.team
  end
end
