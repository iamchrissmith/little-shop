class UsersController < ApplicationController
  include ApplicationHelper
  before_action :set_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    city = City.create(city_params)
    address = city.addresses.create(address_params)
    @user = User.create(user_params)
    @user.addresses << address
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{full_name(@user)}"
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    # binding.pry
  end

  private

   def user_params
     params.require(:user).permit(:first_name, :last_name, :email, :password)
   end

   def address_params
     params.require(:user).require(:address).permit(:address, :zipcode)
   end

   def city_params
     params.require(:user).require(:address).require(:city).permit(:name, :state_id)
   end

   def set_user
     @user = current_user
   end
end
