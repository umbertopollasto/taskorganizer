class SearchBarController < ApplicationController
  include Dry::Monads[:result]

  def search
    query = params[:term]
    users = User.where('email LIKE ?', "%#{query[:term]}%")
    respond_to do |format|
      format.json { render json: { results: users.map { |u| { name: u.email, id: u.id } } } }
    end
  end

  def submit
    @user = User.find(params[:search_bar])

    redirect_to profile_path(id: @user.id)
  rescue StandardError => e
    Failure(e).failure
  end
end
