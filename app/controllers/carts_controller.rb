class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_action :set_referrer, only: %i[create update]
  before_action :item_id, only: %i[create update]
  before_action :item, only: %i[create update]

  def create
    session[:cart] = update_cart(:add_item, id: item_id)
    flash[:notice] = "You now have #{pluralize(session[:cart][item_id], item.name)} in your cart."
    redirect_to session.delete(:return_to)
  end

  def update
    new_quantity = params[:quantity].to_i
    opts = { id: item_id, quantity: new_quantity }
    session[:cart] = update_cart(:change_quantity, opts)
    flash[:notice] = "Quantity of #{item.name} updated."
    redirect_to session.delete(:return_to)
  end

  def show; end
  
  def destroy
    id = params[:item_id].to_s
    @cart.remove_item(id)
    session[:cart] = @cart.contents
    cart_link = "<a href=\"#{url_for(item)}\">#{item.name}</a>"
    flash[:notice] = "Successfully removed #{cart_link} from your cart"
    redirect_to cart_path
  end

  private

  def update_cart(action, opts)
    @cart.send(action, opts)
    @cart.contents
  end

  def set_referrer
    session[:return_to] ||= request.referrer
  end

  def item_id
    params[:item_id].to_s
    id = params[:item_id].to_s
    item = Item.find(id)
    @cart.add_item(id)
    session[:cart] = @cart.contents

    flash[:notice] = "You now have #{pluralize(session[:cart][id], item.name)} in your cart."
    redirect_to root_path
  end

  def item
    Item.find(item_id)
  end

end
