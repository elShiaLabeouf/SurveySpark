# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return @current_user if defined? @current_user

    @current_user = User.find_by(id: cookies[:user_id]) if cookies[:user_id].present?
    return @current_user if @current_user.present?

    cookies.delete(:user_id)
    @current_user = User.first
    return @current_user if @current_user.present?

    raise "Please, create at least one user in the database"
  end
end
