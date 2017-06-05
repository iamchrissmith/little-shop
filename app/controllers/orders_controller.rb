class OrdersController < ApplicationController

  def new
    @order = Order.new
    # @address = Address.new
    # @order_items = OrderItem.new
  end

  def create
    @order = Order.create(order_params)
    if @order.save
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
    params.require(:order).permit(:user_id, :address_id, :items)
  end
end
