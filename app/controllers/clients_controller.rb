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
    unless client_belongs_to_user?
      redirect_to root_path, notice: "You can only see your own clients"
    end
  end
 
  def create
    existing_client = Client.find_by(name: client_params[:name], user_id: Current.user.id)

    if existing_client
      redirect_to edit_client_path(existing_client), notice: "Looks like you have created this client already. Try editing it here!"
    else
      @client = Client.create_for(client_params, Current.user.id)
      redirect_to client_path(@client)
    end
  end

  def edit
    unless client_belongs_to_user?
      redirect_to root_path, notice: "You can only edit your own clients"
    end
  end

  def update
    @client.update_for(client_params)

    redirect_to client_path(@client)
  end

  def destroy
    unless client_belongs_to_user?
      redirect_to root_path, notice: "You can only delete your own clients"
    else
      @client.destroy
      redirect_to clients_path, notice: "Client #{@client.name} was successfully deleted" 
    end
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_belongs_to_user?
      @client.user_id == Current.user.id
    end

    def client_params
      params.require(:client).permit(:name, :hours_worked, :amount_billed)
    end
end
