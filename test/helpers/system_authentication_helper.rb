module SystemAuthenticationHelper
  def login_as(user)
    visit "/session/new"
    fill_in "Name", with: user.name
    fill_in "Password", with: "secret"
    click_button "Login"
  end
end