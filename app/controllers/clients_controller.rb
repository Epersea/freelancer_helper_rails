class ClientsController < ApplicationController
  before_action :set_user
  before_action :set_client, except: [:new, :create]

  def new
    @client = Client.new
  end
 
  def create
    @client = Client.create_for(client_params, @user_id)

    redirect_to client_path(@client)
  end

  def show
  end

  def edit
  end

  def update
    @client.update_for(client_params)

    redirect_to client_path(@client)
  end

  def destroy
    @client.destroy

    redirect_to root_path, notice: "Client #{@client.name} was successfully deleted" 
  end

  private
    def set_user
      begin
        @user_id = session[:user_id]
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, notice: "User not found"
      end
    end

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name, :hours_worked, :amount_billed)
    end
end
