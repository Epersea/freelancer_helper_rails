class ApplicationController < ActionController::Base
before_action :authorize

protected
  def authorize
    Current.user = User.find_by(id: session[:user_id])

    unless Current.user
      session[:user_id] = nil
      redirect_to new_session_path, notice: "Please log in to use this feature"
    end
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  alias logged_in? current_user
end
