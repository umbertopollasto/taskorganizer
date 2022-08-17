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

  def show
    @role = 'admin' if current_user.has_role? :admin
    @user = User.find(@current_user[:id])
    @total_working_hours = UsersHelper.total_month_hours(@current_user[:id])
    @all_projects = UsersHelper.total_hours_all_project(@current_user[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :surname, :role, :password)
  end
end
