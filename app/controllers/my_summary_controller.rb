class MySummaryController < ApplicationController
  before_action :authorize

  def index
    @user_id = session[:user_id]
    @rate = Rate.find_by(user_id: @user_id)
    user = User.find_by(id: @user_id)
    @username = user.name
  end
end
