class OrdersController < ApplicationController

  def new
    @order = Order.new
    @order.address = Address.new
    @order.address.city = City.new
  end

  def create
    address = Address.create(address_params)
    address.city = City.create(city_params)
    @order = Order.create(order_params)
    @order.address = address
    @order.items << @cart.items_for_order
    if @order.save!
      session.delete(:cart)
      flash[:success] = 'Order was successfully placed'
      redirect_to orders_path
    else
      render :new
    end
  end

  def index
    @orders = current_user.orders.order('created_at DESC')
  end

  private

  def city_params
    params.require(:order).require(:address_attributes).require(:city_attributes).permit(:name, :state_id)
  end

  def address_params
    params.require(:order).require(:address_attributes).permit( :address, :zipcode )
  end

  def order_params
    params.require(:order).permit(:user_id)
  end
end
