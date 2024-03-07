class ClientsController < ApplicationController
  before_action :set_user, only: [:index, :create, :destroy]
  before_action :set_client, except: [:new, :create, :index]

  def index
    @user = User.find(@user_id)
    @clients = Client.where(user_id: @user_id)
  end

  def new
    @client = Client.new
  end
 
  def create
    existing_client = Client.find_by(name: client_params[:name], user_id: @user_id)

    if existing_client
      redirect_to edit_client_path(existing_client), notice: "Looks like you have created this client already. Try editing it here!"
    else
      @client = Client.create_for(client_params, @user_id)
      redirect_to client_path(@client)
    end
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

    redirect_to clients_path, notice: "Client #{@client.name} was successfully deleted" 
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
