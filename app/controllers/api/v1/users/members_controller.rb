class Api::V1::Users::MembersController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:show, :update]

  include Api::Users::AccessControl
  before_action :check_valid_permisson, only: [:show, :update]

  def show
    render 'show', formats: [:json], handlers: [:jbuilder]
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
      :calendar_color
    )
  end

  def set_member
    @member = Member.find(params[:id])
  end
end
