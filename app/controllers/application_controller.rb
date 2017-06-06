class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :categories, :current_user, :current_admin?, :current_cart, :flash_class
  before_action :set_cart

  def categories
    Category.all
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_cart
    @cart ||= Cart.new(session[:cart])
  end

  def flash_class(level)
      case level
          when 'notice' then "alert alert-success"
          when 'success' then "alert alert-success"
          when 'error' then "alert alert-error"
          when 'alert' then "alert alert-error"
      end
  end

  def require_user
    unless current_user
      flash[:warning] = 'You must be logged in to access this page.'
      redirect_to login_path
    end
  end

  private

  def set_cart
    @cart = current_cart
  end
end
