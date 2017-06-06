class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      if @user.admin?
        flash[:success] = "Admin Logged in as #{@user.email}"
        redirect_to admin_dashboard_path
      else
        flash[:success] = "Logged in as #{@user.email}"
        redirect_to dashboard_path
      end
    else
      flash[:error] = 'Incorrect Password or Username'
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = 'Successfully logged out!'
    redirect_to root_path
  end

end
