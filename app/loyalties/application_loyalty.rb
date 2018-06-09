class ApplicationLoyalty
  attr_reader :user, :current_member

  def initialize(user, current_member)
    @user = user
    @current_member = current_member
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
end
