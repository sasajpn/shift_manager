class Owners::ShiftRegistrationsController < Owners::ApplicationController
  before_action :set_shift_registration, only: [:edit, :destroy]
  before_action :set_member, only: [:new, :edit]
  before_action :set_team, only: [:new, :edit]

  include Owners::AccessControl

  def new
  end

  def edit
  end

  def destroy
    @shift_registration.destroy
    redirect_to owners_member_url(@shift_registration.member), flash: { success: 'シフトの登録を削除しました' }
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
