class Owners::ApplicationController < ApplicationController
  layout 'owners/application'
  before_action :authenticate_owner!

  def current_owner
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end
end
