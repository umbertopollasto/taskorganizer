class WorkDaysController < ApplicationController
  def index
    @work_day = ProjectUser.new
    @work_days = ProjectUser.all
    @users = User.all.select('id', 'name', 'surname')
    @projects = Project.all.select('id', 'name')
  end

  def create
    ProjectUser.transaction do
      @work_day = ProjectUser.new(project_user_params)
      @work_days = ProjectUser.all

      if @work_day.save
        redirect_to work_day_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def project_user_params
    params.require(:project_user).permit(:user_id, :project_id, :work_start, :work_end)
  end
end
