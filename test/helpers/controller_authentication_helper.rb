module ControllerAuthenticationHelper
  def login_as(user)
    post session_path, params: {
      name: user.name,
      password: 'secret'
    }
  end
end