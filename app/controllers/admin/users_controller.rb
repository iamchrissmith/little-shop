class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :index]

  def show
  end

  def index
    @orders = Order.all
  end

  private

  def set_user
    @user = current_user
  end

end