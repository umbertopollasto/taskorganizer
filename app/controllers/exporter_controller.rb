class ExporterController < ApplicationController
  include Dry::Monads[:result]
  def new; end

  def create
    start_month = Date.parse("#{params[:start_date]}-01") unless params[:start_date].blank?
    unless ExporterHelper.is_date(start_month)
      redirect_to export_path,
                  flash: { alert: Failure('Invalid date').failure } and return
    end

    rows = download_csv(start_month, start_month.end_of_month)
    export_data, data_type = WorkDaysController.export(rows)
    send_data export_data, type: data_type, disposition: 'attachment; filename= export_all.csv'
  rescue StandardError => e
    redirect_to export_path, flash: { alert: Failure(e).failure }
  end

  private

  def download_csv(start, end_month)
    users = User.all
    rows = []
    users.each do |user|
      total_working_hours = WorkDaysHelper.total_month_hours(user.id, start, end_month)
      all_projects = WorkDaysHelper.total_hours_all_project(user.id, start, end_month)
      next unless all_projects.any?

      all_projects.map do |project|
        rows.push([user.email, project['name'], (project['working_hours'].to_f / total_working_hours) * 100])
      end
    end
    rows
  end
end
