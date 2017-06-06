class UsersController < ApplicationController
  include ApplicationHelper
  before_action :set_user, only: [:show]

  before_action :require_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{full_name(@user)}"

      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def set_user
    @user = current_user
    redirect_to admin_user_path(@user) if current_admin?
  end
end
