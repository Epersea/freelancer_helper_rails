class UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :show, :update, :destroy ]
  skip_before_action :authorize, except: [ :edit, :show, :destroy ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: "User #{@user.name} was successfully created"
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def show
    if !user_authorized?
      redirect_to root_path, notice: "You can only see your own account"
    end
  end

  def edit
    if !user_authorized?
      redirect_to root_path, notice: "You can only edit your own account"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "User #{@user.name} was successfully updated" 
    else
      render :edit, status: :unprocessable_entity
    end
  end
 
  def destroy
    if !user_authorized?
      redirect_to root_path, notice: "You can only delete your own account"
    else
      ActiveRecord::Base.transaction do
        session[:user_id] = nil
        @user.destroy!
      end
      redirect_to root_path, notice: "User #{@user.name} was successfully deleted" 
    end
  end

  private
    def set_user
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, notice: "User not found"
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_authorized?
      session[:user_id] == params[:id].to_i
    end
end
