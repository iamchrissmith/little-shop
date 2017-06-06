class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :index]

  def show
  end

  def index
    @orders = Order.order('created_at DESC')
    @ordered_orders = Order.where(status: "ordered").order('created_at DESC')
    @paid_orders = Order.where(status: "paid").order('created_at DESC')
    @completed_orders = Order.where(status: "completed").order('created_at DESC')
    @cancelled_orders = Order.where(status: "cancelled").order('created_at DESC')
  end

  private

  def set_user
    @user = current_user
  end

end