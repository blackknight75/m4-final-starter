class SessionsController < ApplicationController
  def new

  end

  def create
    binding.pry
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

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
