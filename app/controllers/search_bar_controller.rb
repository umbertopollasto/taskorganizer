class SearchBarController < ApplicationController
  def search
    query = params[:term]
    users = User.where('email LIKE ?', "%#{query[:term]}%")
    respond_to do |format|
      format.json { render json: { results: users.map { |u| { name: u.email, id: u.id } } } }
    end
  end
end
