class ProjectsController < ApplicationController
  before_action :set_client, except: [:show, :edit]
  before_action :set_project, only: [:show, :edit]

  def index
    @projects = @client.projects.sort_by(&:start_date)
  end

  def new
    @project = Project.new
  end

  def create
    @project = @client.projects.create(project_params)
    redirect_to project_path(@project)
  end

  def show
  end

  def edit
  end

  private
    def set_client
      @client = Current.user.clients.find(params[:client_id])
    end

    def set_project
      @project = Current.user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :hours_worked, :amount_billed, :start_date, :end_date, :description)
    end

end