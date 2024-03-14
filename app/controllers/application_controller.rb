class ApplicationController < ActionController::Base
before_action :authorize

protected
  def authorize
    unless User.find_by(id: session[:user_id])
      session[:user_id] = nil
      redirect_to login_url, notice: "Please log in to use this feature"
    end
  end

  def set_logged_user
    begin
      @user_id = session[:user_id]
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, notice: "User not found"
    end
  end

  def user_authorized
    session[:user_id] == params[:id].to_i
  end
end
