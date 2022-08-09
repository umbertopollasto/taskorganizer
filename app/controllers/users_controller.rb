class UsersController < ApplicationController
  def new
    @user = User.new
    @users = User.all
  end

  def create
    User.transaction do
      @user = User.new(user_params)
      @exists = User.where(username: @user[:username]).take || User.where(email: @user[:email]).take

      if !@exists && @user.save
        redirect_to add_user_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def delete; end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password_digest)
  end
end
