module SystemAuthenticationHelper
  def login_as(user)
    visit new_session_path
    fill_in "Name", with: user.name
    fill_in "Password", with: "secret"
    click_button "Login"
  end
end