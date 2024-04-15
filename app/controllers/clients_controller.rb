class ClientsController < ApplicationController
  before_action :set_client, except: [:new, :create, :index]

  def index
    @user = Current.user
    @clients = Current.user.clients
  end

  def new
    @client = Client.new
  end

  def show
  end
 
  def create
    if existing_client
      redirect_to edit_client_path(existing_client), notice: "Looks like you have created this client already. Try editing it here!"
    else
      @client = Current.user.clients.create(client_params)
      redirect_to client_path(@client)
    end
  end

  def edit
  end

  def update
    @client.update(client_params)

    redirect_to client_path(@client)
  end

  def destroy
    @client.destroy
    redirect_to clients_path, notice: "Client #{@client.name} was successfully deleted" 
  end

  private
    def set_client
      @client = Current.user.clients.find(params[:id])
    end

    def existing_client
      Current.user.clients.find_by(name: client_params[:name])
    end

    def client_params
      params.require(:client).permit(:name, :hours_worked, :amount_billed)
    end
end
