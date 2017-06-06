class OrdersController < ApplicationController

  before_action :require_user

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(order_params)
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

  # def city_params
  #   params.require(:order).require(:address_attributes).require(:city_attributes).permit(:name, :state_id)
  # end
  #
  # def address_params
  #   params.require(:order).require(:address_attributes).permit(  )
  # end

  def order_params
    params.require(:order).permit(:user_id, address_attributes: [:address, :zipcode, city_attributes: [:name, :state_id]])
  end

  def require_user
    unless current_user
      flash[:warning] = 'You must be logged in to access this page.'
      redirect_to login_path
    end
  end
end
