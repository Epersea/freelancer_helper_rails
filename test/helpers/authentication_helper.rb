module AuthenticationHelper
  def login_as(user)
    post "/login", params: {
      name: user.name,
      password: 'secret'
    }
  end
end