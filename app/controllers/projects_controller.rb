# frozen_string_literal: true

#
# Projects controller
#
class ProjectsController < ApplicationController
  include Dry::Monads[:result]
  def new
    @project = Project.new
    @projects = Project.all
  end

  def create
    @project = Project.new(project_params)
    @projects = Project.all

    redirect_to add_project_path and return if @project.save

    render :new, status: :unprocessable_entity
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
