class Api::V1::Owners::MembersController < Api::V1::Owners::ApplicationController
  before_action :set_member, only: [:show, :update]

  include Api::Owners::AccessControl

  def show
    render json: @member, only: [:role, :shift_coordinator]
  end

  def update
    if @member.update(member_params)
      flash[:notice] = 'メンバーの登録内容を変更しました'
      render json: { status: 200 }
    else
      @error_messages = @member.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  private

  def member_params
    params.fetch(:member, {}).permit(
      :role, :shift_coordinator
    )
  end

  def set_member
    @member = Member.find(params[:id])
  end
end
