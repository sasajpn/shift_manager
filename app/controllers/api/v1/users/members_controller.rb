class Api::V1::Users::MembersController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:show, :update]

  include Api::Users::AccessControl

  def show
    render json: @member, only: [:team_id, :calendar_color]
  end

  def update
    if @member.update(member_params)
      flash[:notice] = '登録内容を変更しました'
      render json: { status: 200 }
    else
      @error_messages = @member.errors.full_messages
      render json: { error_messages: @error_messages, status: 400 }
    end
  end

  private

  def member_params
    params.fetch(:member, {}).permit(
      :calendar_color
    )
  end
end
