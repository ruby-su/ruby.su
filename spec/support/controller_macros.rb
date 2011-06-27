module ControllerMacros
  def login_admin
    before(:each) do
      request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in Factory.create(:admin)
    end
  end

  def login_user
    let(:user) { Factory.create(:regular_user) }
    before(:each) do
      request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
      request.env['warden'] = mock(Warden, :authenticate => user, :authenticate! => user)
    end
  end
end
