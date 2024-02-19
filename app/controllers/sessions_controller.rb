class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:name]) 
    
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to my_summary_url
    else
      redirect_to login_url, notice: "Invalid user/password combination"
    end
  end

  def destroy
  end
end

