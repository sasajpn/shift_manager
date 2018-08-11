module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in admin
    end
  end

  def login_owner
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:owner]
      owner = FactoryBot.create(:owner)
      sign_in owner
    end
  end

  def login_user
    controller.stub(:authenticate_user!).and_return true
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end
