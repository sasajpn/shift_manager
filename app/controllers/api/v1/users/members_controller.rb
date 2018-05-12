class Api::V1::Users::MembersController < Api::V1::Users::ApplicationController
  before_action :set_member, only: [:edit, :update]

  def edit
  end

  def update
    if @member.update(member_params)
      render :update
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
