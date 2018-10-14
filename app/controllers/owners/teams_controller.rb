class Owners::TeamsController < Owners::ApplicationController
  before_action :set_team, only: [:show, :edit, :update_identifier]

  include Owners::AccessControl
  before_action :check_valid_permisson, except: [:new]


  def show
    @unapprovals = @team.members.unapprovals
  end

  def new

  end

  def edit

  end

  def update_identifier
    if @team.update(identifier: SecureRandom.hex(5))
      redirect_to owners_team_url(@team), flash: { success: 'チームの認証コードを更新しました' }
    else
      render :show
    end
  end
end
