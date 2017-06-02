class UsersController < ApplicationController
  include ApplicationHelper

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

  def show

  end

  private

   def user_params
     params.require(:user).permit(:first_name, :last_name, :email, :password, :address)
   end
end
