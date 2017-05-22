class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to links_path, notice: "You have successfully logged in!"
    else
      redirect_to '/login', alert: "Email or Password is incorrect!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
