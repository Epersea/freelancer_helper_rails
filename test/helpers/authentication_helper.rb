module AuthenticationHelper
  def login_as(user)
    if respond_to? :visit
      visit "/session/new"
      fill_in "Name", with: user.name
      fill_in "Password", with: "secret"
      click_button "Login"
    else
      post "/session", params: {
        name: user.name,
        password: 'secret'
      }
    end
  end
end