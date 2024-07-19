# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return User.find(cookies[:user_id]) if cookies[:user_id].present?

    User.first
  end
end
