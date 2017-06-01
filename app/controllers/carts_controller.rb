class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    # binding.pry
    id = params[:item_id].to_s
    item = Item.find(id)
    session[:cart] ||= {}
    session[:cart][id] = (session[:cart][id] || 0) + 1
    flash[:notice] = "You now have #{pluralize(session[:cart][id], item.name)} in your cart."
    redirect_to root_path
  end

end
