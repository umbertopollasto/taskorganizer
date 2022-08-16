#
# <Description>
#
class WorkDaysController < ApplicationController
  def init
    @users = set_users
    @projects = ProjectUser.select(:project_id, :user_id).distinct.where(user_id: @current_user[:id])
    # Today at 9 am
    @start_date = (DateTime.now.beginning_of_day + 9.hours).strftime('%Y-%m-%dT%H:%M')
    # Today at 6 pm
    @end_date = (DateTime.now.beginning_of_day + 18.hours).strftime('%Y-%m-%dT%H:%M')
  end

  #
  # <Description>
  #
  # @return [<Type>] <description>
  #
  def index
    init
    @work_day = WorkDay.new
  end

  #
  # <Description>
  #
  # @return [<Type>] <description>
  #
  def create
    init
    ProjectUser.transaction do
      @work_day = WorkDay.new(project_user_params)
      if @work_day.save
        redirect_to work_day_path
      else
        render :index, status: :unprocessable_entity
      end
    end
  end

  private

  #
  # <Description>
  #
  # @return [<Type>] <description>
  #
  def project_user_params
    params.require(:work_day).permit(:user_id, :project_id, :work_start, :work_end)
  end

  def set_users
    User.select('id', 'name', 'surname').all # find(@current_user[:id])
  end
end
