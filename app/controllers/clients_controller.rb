class ClientsController < ApplicationController

  def new
    @client = Client.new
  end
 
end
