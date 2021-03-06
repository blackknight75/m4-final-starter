class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to links_path, notice: "You have successfully created an account!"
    else
      flash[:alert] = "Sorry, but that email has already been taken."
      redirect_to signup_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
