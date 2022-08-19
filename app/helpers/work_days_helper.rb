#
# <Description>
#
module WorkDaysHelper
  def self.exists(user_id, work_start, work_end)
    WorkDay.where(user_id: user_id).and(WorkDay.where(work_start: work_start..work_end).or(WorkDay.where(work_end: work_start..work_end)))
  end

  def self.total_month_hours(user_id, start_month, end_month)
    return unless user_id

    @total_hours = 0
    work_days = WorkDay.where(user_id: user_id.to_s).and(WorkDay.where(work_start: start_month..end_month))

    work_days.each do |day|
      @start_day = Time.parse(day[:work_start].strftime('%Y-%m-%dT%H:%M'))
      @end_day = Time.parse(day[:work_end].strftime('%Y-%m-%dT%H:%M'))
      @working_hours = @start_day.business_time_until(@end_day) / 3600
      @total_hours += @working_hours
    end

    @total_hours
  end

  # TODO: Refactoring da fare
  def self.total_hours_all_project(user_id, start_month, end_month)
    return unless user_id

    @all_project = []

    projects = WorkDay.select(:project_id).where(user_id: user_id.to_s).and(WorkDay.where(work_start: start_month..end_month)).distinct
    projects.each do |project|
      total_hours = 0
      work_days = WorkDay.where(user_id: user_id.to_s,
                                project_id: project.project_id).and(WorkDay.where(work_start: start_month..end_month))
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
