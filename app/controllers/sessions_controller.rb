class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      flash[:success] = "Logged in as #{@user.email}"
      session[:user_id] = @user.id

      if @user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to dashboard_path
      end
    else
      flash[:error] = 'Incorrect Password or Username'
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = 'Logged Out'
    redirect_to root_path
  end

end
