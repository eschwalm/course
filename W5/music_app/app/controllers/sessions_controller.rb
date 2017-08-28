class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
              params[:user][:email],
              params[:user][:password])

    if user.nil?
      render json: 'Invalid Credentials'
      render :new
    else
      login!(user)
      redirect_to bands_url
    end
  end

  def destroy
    logout_user!

    redirect_to root_url
  end
end
