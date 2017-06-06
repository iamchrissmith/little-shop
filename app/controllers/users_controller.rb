class UsersController < ApplicationController
  include ApplicationHelper
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_admin, only: :show

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

  def edit; end

  def update
    if @user = User.update(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def set_user
    @user = current_user
  end

  def check_admin
    redirect_to admin_user_path(@user) if current_admin?
  end
end
