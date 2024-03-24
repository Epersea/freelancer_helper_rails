module ControllerAuthenticationHelper
  def login_as(user)
    post "/session", params: {
      name: user.name,
      password: 'secret'
    }
  end
end