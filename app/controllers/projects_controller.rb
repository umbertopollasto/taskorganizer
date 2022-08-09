class ProjectsController < ApplicationController
  def new
    @project = Project.new
    @projects = Project.all
  end

  def create
    @project = Project.new(project_params)
    @projects = Project.all

    if @project.save
      redirect_to add_project_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
