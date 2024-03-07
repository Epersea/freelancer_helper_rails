class ClientsController < ApplicationController
  before_action :set_user

  def new
    @client = Client.new
  end
 
  def create
    @client = Client.create_for(client_params, @user_id)

    redirect_to client_path(@client)
  end

  def show
    @client = Client.find(params[:id])
  end

  private
    def set_user
      @user_id = session[:user_id]
    end

    def client_params
      params.require(:client).permit(:name, :hours_worked, :amount_billed)
    end
end
