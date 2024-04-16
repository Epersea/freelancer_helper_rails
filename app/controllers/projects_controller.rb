class ProjectsController < ApplicationController

  def index
    @client = Current.user.clients.find(params[:client_id])
    @projects = @client.projects
  end

  def new
    @client = Current.user.clients.find(params[:client_id])
    @project = Project.new
  end

end