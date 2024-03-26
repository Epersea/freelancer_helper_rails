class ApplicationController < ActionController::Base
before_action :authorize

protected
  def authorize
    unless User.find_by(id: session[:user_id])
      session[:user_id] = nil
      redirect_to new_session_path, notice: "Please log in to use this feature"
    end
  end

  def set_logged_user
    @user_id = session[:user_id]
  end
end
