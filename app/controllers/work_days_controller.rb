#
# <Description>
#
class WorkDaysController < ApplicationController
  include Dry::Monads[:result]

  def init
    @users = set_users
    @projects = ProjectUser.select(:project_id, :user_id).distinct.where(user_id: current_user.id)
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
      if WorkDaysHelper.exists(@work_day.user_id, @work_day.work_start, @work_day.work_end).blank? && @work_day.save
        redirect_to work_day_path, flash: { notice: 'Work day added' }
      else
        redirect_to work_day_path, flash: { alert: 'Work day has already present' }
      end
    end
  end

  def self.export(rows)
    WorkDay.create_report('csv', rows, { headers: ['Employee', 'Project', 'Hours %'] })
  end

  private

  def project_user_params
    params.require(:work_day).permit(:user_id, :project_id, :work_start, :work_end)
  end

  def set_users
    return current_user unless @is_admin

    User.select('id', 'email').all
  end

  #
  #  Export of all hours spent for each projects for each user
  #
  # @return
  #
  def export_all
    rows = []
    users = User.all

    users.each do |user|
      total_working_hours = WorkDaysHelper.total_month_hours(user.id)
      all_projects = WorkDaysHelper.total_hours_all_project(user.id)
      next unless all_projects.any?

      all_projects.map do |project|
        rows.push([user.email, project['name'], (project['working_hours'].to_f / total_working_hours) * 100])
      end
    end
  end
end
