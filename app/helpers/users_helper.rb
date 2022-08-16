module UsersHelper
  def self.total_month_hours(user_id)
    return unless user_id

    @total_hours = 0
    work_days = WorkDay.where(user_id: user_id.to_s)

    work_days.each do |day|
      @start_day = Time.parse(day[:work_start].strftime('%Y-%m-%dT%H:%M'))
      @end_day = Time.parse(day[:work_end].strftime('%Y-%m-%dT%H:%M'))
      @working_hours = @start_day.business_time_until(@end_day) / 3600
      @total_hours += @working_hours
    end

    @total_hours
  end

  def self.total_hours_all_project(user_id)
    @all_project = []
    projects = WorkDay.select(:project_id).where(user_id: user_id.to_s).distinct
    projects.each do |project|
      total_hours = 0
      work_days = WorkDay.where(user_id: user_id.to_s, project_id: project.project_id)
      work_days.each do |day|
        start_day = Time.parse(day[:work_start].strftime('%Y-%m-%dT%H:%M'))
        end_day = Time.parse(day[:work_end].strftime('%Y-%m-%dT%H:%M'))
        working_hours = start_day.business_time_until(end_day) / 3600
        total_hours += working_hours
      end
      @all_project.push('name' => project.project.name, 'working_hours' => total_hours)
    end

    @all_project
  end
end
