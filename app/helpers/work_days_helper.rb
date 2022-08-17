#
# <Description>
#
module WorkDaysHelper
  def self.exists(user_id, work_start, work_end)
    WorkDay.where(user_id: user_id).and(WorkDay.where(work_start: work_start..work_end).or(WorkDay.where(work_end: work_start..work_end)))
  end

  
end
