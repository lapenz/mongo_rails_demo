module ControllerMacros
  def login_user
    # Before each test, create and login the user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @current_user = create(:user)
      sign_in @current_user
    end
  end

end