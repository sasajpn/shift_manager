class Api::V1::Owners::Members::CalendarsController < Api::V1::Owners::ApplicationController
  before_action :set_member, only: [:index]
  before_action :set_team, only: [:index]

  include Api::Owners::AccessControl

  def index
    @shift_submissions = @member.shift_submissions.unapprovals
    @shift_adjustments = @member.shift_adjustments
    @shift_registrations = @member.shift_registrations
    render 'index', formats: [:json], handlers: [:jbuilder]
  end

  private

  def set_member
    @member = Member.find_by(id: params[:member_id])
  end

  def set_team
    @team = @member.team
  end
end
