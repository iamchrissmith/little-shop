class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_action :set_referrer, only: [:create, :update]
  before_action :item_id, only: [:create, :update]
  before_action :item, only: [:create, :update]

  def create
    session[:cart] = update_cart(:add_item, item_id)
    flash[:notice] = "You now have #{pluralize(session[:cart][item_id], item.name)} in your cart."
    redirect_to session.delete(:return_to)
  end

  def update
    new_quantity = params[:quantity].to_i
    if new_quantity > current_cart.contents[item_id]
      session[:cart] = update_cart(:add_item, item_id)
    else
      session[:cart] = update_cart(:remove_item, item_id)
    end
    flash[:notice] = "Quantity of #{item.name} updated."
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

  def item_id
    params[:item_id].to_s
  end

  def item
    Item.find(item_id)
  end
end
