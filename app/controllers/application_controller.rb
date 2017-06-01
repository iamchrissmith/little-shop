class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :categories

  def categories
    categories = Category.all
  end

end
