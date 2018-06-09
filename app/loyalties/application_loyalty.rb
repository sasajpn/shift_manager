class ApplicationLoyalty
  attr_reader :user, :member

  def initialize(user, member)
    @user = user
    @member = member
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
