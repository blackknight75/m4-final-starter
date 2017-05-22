class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    binding.pry
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path, notice: "You have successfully created an account!"
    else
      flash[:alert] = "Sorry, but that email has already been taken."
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
