class UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :show, :update, :destroy ]
  skip_before_action :authorize, except: [ :edit, :show, :destroy ]

  def new
    if session[:user_id]
      redirect_to root_path, notice: "You are already logged in. To create an account, please log out first."
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_session_path, notice: "User #{@user.name} was successfully created"
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "User #{@user.name} was successfully updated" 
    else
      render :edit, status: :unprocessable_entity
    end
  end
 
  def destroy
    session[:user_id] = nil
    @user.destroy!
    redirect_to root_path, notice: "User #{@user.name} was successfully deleted" 
  end

  private
    def set_user
      begin
        @user = User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, notice: "User not found"
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
