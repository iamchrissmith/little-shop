class OrdersController < ApplicationController

  def new
    @order = Order.new
    # @address = Address.new
    # @order_items = OrderItem.new
  end

  def create
    @order = Order.create(order_params)
    @order.items << @cart.items_for_order
    # binding.pry
    if @order.save!
      session.delete(:cart)
      flash[:success] = 'Order was successfully placed'
      redirect_to orders_path
    else
      render :new
    end
  end

  def index
    @orders = current_user.orders
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :address_id)
  end

  def method_name

  end
end
