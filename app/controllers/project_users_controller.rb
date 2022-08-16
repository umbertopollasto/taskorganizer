require 'dry/monads'

#
# <Description>
#
class ProjectUsersController < ApplicationController
  include Dry::Monads[:result]
  def new
    init
    @project_user = ProjectUser.new
  end

  def create
    init
    @project_user = ProjectUser.new(set_params)

    redirect_to project_user_path and return if @project_user.save

    render :new, status: :unprocessable_entity
  rescue StandardError => e
    flash[:alert] = "#{@project_user.user.email} is already working on   #{@project_user.project.name}"
    render :new, status: :unprocessable_entity
  end

  private

  def set_params
    params.require(:project_user).permit(:user_id, :project_id)
  end

  def init
    @users = User.all
    @projects = Project.all
  end
end
