# frozen_string_literal: true

#
# ApplicationController

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
 
  before_action :set_current_user
  

  #
  # Set current user global attributes like name , surname , email
  #
  # @return User
  #
  def set_current_user
    @current_user = current_user
  end
end
