module AuthenticationHelper
  def login_as(user)
    if respond_to? :visit
      visit "/login"
      fill_in "Name", with: user.name
      fill_in "Password", with: "secret"
      click_button "Login"
    else
      post "/login", params: {
        name: user.name,
        password: 'secret'
      }
    end
  end
end