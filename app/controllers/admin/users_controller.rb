class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show]

  def show; end

  def set_user
    @user = current_user
  end

end