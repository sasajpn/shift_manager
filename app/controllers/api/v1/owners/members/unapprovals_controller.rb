class Api::V1::Owners::Members::UnapprovalsController < Api::V1::Owners::ApplicationController
  before_action :set_member, only: [:update]

  include Api::Owners::AccessControl

  def update
    if @member.update(member_params)
      @member.team.increase_stripe_quantity
      flash[:notice] = 'メンバーの参加を承認しました'
      render json: { status: 200 }
    else
      @error_messages = @member.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  private

  def have_valid_permission?
    team = @member.team
    team.owner == current_owner && !@member.approve?
  end

  def member_params
    params.fetch(:member, {}).permit(
        :approve, :role, :shift_coordinator
    )
  end

  def set_member
    @member = Member.find_by(id: params[:id])
  end
end
