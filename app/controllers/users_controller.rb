class UsersController < ApplicationController
  def new
    @user = User.new
    @users = User.all
  end

  def create
    User.transaction do
      @user = User.new(user_params)
      @users = User.all
      @exists = User.where(email: @user[:email]).take

      if !@exists && @user.save
        redirect_to add_user_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :surname, :role, :password_digest)
  end
end
