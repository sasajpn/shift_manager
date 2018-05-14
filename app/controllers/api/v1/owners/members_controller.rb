class Api::V1::Owners::MembersController < Api::V1::Owners::ApplicationController
  before_action :set_member, only: [:edit, :update]

  def edit
  end

  def update
    if @member.update(member_params)
      @success_message = 'メンバーの設定内容を変更しました。'
      render 'api/v1/shared/success', formats: [:json], handlers: [:jbuilder]
    else
      @error_messages = @member.errors.full_messages
      render "api/v1/users/shared/error_messages", formats: [:json], handlers: [:jbuilder]
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
