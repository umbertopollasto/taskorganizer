# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    @users = User.all

    if @user.save
      redirect_to add_user_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  #
  # <Description>
  #
  # @return [<Type>] <description>
  #
  def show
    @role = 'admin' if current_user.has_role? :admin

    @user = User.find(params[:id])

    @month = params[:month].blank? ? Date.today : Date.parse(params[:month])
    @total_working_hours = WorkDaysHelper.total_month_hours(@user.id, @month.at_beginning_of_month,
                                                            @month.end_of_month)
    @all_projects = WorkDaysHelper.total_hours_all_project(@user.id, @month.at_beginning_of_month,
                                                           @month.end_of_month)
  rescue StandardError => e
    redirect_to root_path, flash: { alert: Failure(e).failure }
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :surname, :role, :password)
  end
end
