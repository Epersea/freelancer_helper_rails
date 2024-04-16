class ProjectsController < ApplicationController
  before_action :set_client, except: [:show, :edit]

  def index
    @projects = @client.projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = @client.projects.create(project_params)
    redirect_to project_path(@project)
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  private
    def set_client
      @client = Current.user.clients.find(params[:client_id])
    end

    def project_params
      params.require(:project).permit(:name, :hours_worked, :amount_billed, :description)
    end

end