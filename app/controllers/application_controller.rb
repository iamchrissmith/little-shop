class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :categories, :current_user

  def categories
    categories = Category.all
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
