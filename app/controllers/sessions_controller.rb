class SessionsController < ApplicationController
  skip_before_action :authorize
  
  def new
    if session[:user_id]
      redirect_to root_path, notice: "You are already logged in"
    end
  end

  def create
    user = User.find_by(name: params[:name]) 

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to my_summary_url
    else
      redirect_to new_session_path, notice: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end

