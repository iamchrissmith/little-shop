class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    id = params[:item_id].to_s
    item = Item.find(id)
    @cart.add_item(id)
    session[:cart] = @cart.contents

    flash[:notice] = "You now have #{pluralize(session[:cart][id], item.name)} in your cart."
    redirect_to root_path
  end

  def show
  end
end
