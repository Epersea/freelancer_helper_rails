class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy ]

  def new
    @user = User.new
  end

  def edit
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
    assigned_rate = Rate.find_by(user_id: @user.id)

    if assigned_rate != nil
        assigned_rate.destroy!
        @user.destroy!
    else
      @user.destroy!
    end

    redirect_to root_path, notice: "User #{@user.name} was successfully deleted" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, notice: "User not found"
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
