# frozen_string_literal: true

#
# ApplicationController
require 'dry/monads'

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :set_role
  protect_from_forgery prepend: true
  #
  # Set current user global attributes like name , surname , email
  #
  # @return User
  #
  def set_current_user
    @current_user = current_user
  end

  def set_role
    @is_admin = (current_user and current_user.has_role? :admin)
  end
end
