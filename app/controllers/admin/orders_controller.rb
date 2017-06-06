class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: [:update, :show]

  def update
    if @order.update(order_params)
      flash[:success] = "Order Status #{@order.id} Updated to #{@order.status}"
      redirect_to admin_dashboard_path
    else
      flash[:error] = "Order #{@order.id} Failed to Update"
      redirect_to admin_dashboard_path
    end
  end

  def show ; end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :user_id, :address_id)
  end


end


