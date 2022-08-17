require 'csv'

class ExporterController < ApplicationController
  def new; end

  def create
    rows = []
    # start_month = Date.parse(params[:start_date] + '-01') unless params[:start_date].blank?
    # end_month = start_month.end_of_month
    rows = download_csv('', '')
    # Exporter.export(rows)

    export_data, data_type = WorkDaysController.export(rows)
    send_data export_data, type: 'text/csv', disposition: 'attachment; filename= export_all.csv'
  end

  private

  def download_csv(_start, _end_month)
    users = User.all
    rows = []
    users.each do |user|
      total_working_hours = UsersHelper.total_month_hours(user.id)
      all_projects = UsersHelper.total_hours_all_project(user.id)
      next unless all_projects.any?

      all_projects.map do |project|
        rows.push([user.email, project['name'], (project['working_hours'].to_f / total_working_hours) * 100])
      end
    end
    rows
  end
end
