class Users::ShiftAdjustmentsController < Users::ApplicationController
  before_action :set_team, only: [:index]
  before_action :set_member, only: [:index]

  def index
    @shift_adjustments = @member.shift_adjustments.page(params[:page]).per(15)
  end
end
