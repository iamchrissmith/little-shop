class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :index]

  def show
  end

  def index
    #@orders = Order.all
    @orders = Order.order('created_at DESC')
  end

  private

  def set_user
    @user = current_user
  end

end