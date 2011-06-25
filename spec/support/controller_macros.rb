module ControllerMacros
  def login_admin
    before(:each) do
      #@request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in Factory.create(:admin)
    end
  end

  def login_user
    before(:each) do
      #@request.env["devise.mapping"] = Devise.mappings[:user]
      
      @user = Factory.create(:regular_user)
      sign_in @user
    end
  end
end
