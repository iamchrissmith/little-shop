class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_action :set_referrer, only: [:create]

  def create
    id = params[:item_id].to_s
    item = Item.find(id)
    session[:cart] = update_cart(:add_item, id)
    flash[:notice] = "You now have #{pluralize(session[:cart][id], item.name)} in your cart."
    redirect_to session.delete(:return_to)
  end

  def show; end

  private

  def update_cart(action, id)
    @cart.send(action, id)
    @cart.contents
  end

  def set_referrer
    session[:return_to] ||= request.referrer
  end
end
