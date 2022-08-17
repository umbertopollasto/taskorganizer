# frozen_string_literal: true

#
# <Description>
#
class ProjectUsersController < ApplicationController
  include Dry::Monads[:result]
  before_action :admin
  def new
    init
    @project_user = ProjectUser.new
  end

  def create
    init
    @project_user = ProjectUser.new(set_params)
    redirect_to project_users_path, flash: { notice: 'Success' } and return  if @project_user.save
  rescue StandardError => e
    flash[:alert] = Failure(e) # "#{@project_user.user.email} is already working on   #{@project_user.project.name}"
    render :new, status: :unprocessable_entity
  end

  def users_by_project
    users = params[:id] == 'empty' ? ProjectUser.select(:user_id).all : ProjectUser.select(:user_id).where(project_id: params[:id])

    respond_to do |format|
      format.json { render json: { results: users.map { |u| { name: u.user.email, id: u.user.id } } } }
    end
  end

  def projects_by_user
    projects = params[:id] == 'empty' ? ProjectUser.select(:project_id).distinct : ProjectUser.select(:project_id).where(user_id: params[:id]).distinct

    respond_to do |format|
      format.json { render json: { results: projects.map { |u| { name: u.project.name, id: u.project.id } } } }
    end
  end

  private

  def set_params
    params.require(:project_user).permit(:user_id, :project_id)
  end

  def init
    @users = User.all
    @projects = Project.all
  end

  def admin
    redirect_to root_path unless current_user.has_role? :admin
  end
end
