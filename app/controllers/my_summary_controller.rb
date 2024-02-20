class MySummaryController < ApplicationController
  def index
    @user_id = session[:user_id]
    if @user_id != nil
      @rate = Rate.find_by(user_id: @user_id)
      user = User.find_by(id: @user_id)
      @username = user.name
    end
  end
end
