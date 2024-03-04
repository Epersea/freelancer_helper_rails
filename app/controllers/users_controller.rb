class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit show update destroy ]
  before_action :authorize, only: %i[ edit show ]

  def new
    @user = User.new
  end

  def show
  end

  def edit
    if session[:user_id] != params[:id].to_i
      redirect_to root_path, notice: "You can only edit your own account"
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: "User #{@user.name} was successfully created"
    else
      render :new, status: :unprocessable_entity 
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
    ActiveRecord::Base.transaction do
      if session[:user_id] = @user.id
        session[:user_id] = nil
      end

      @user.destroy!
    end

    redirect_to root_path, notice: "User #{@user.name} was successfully deleted" 
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
end
