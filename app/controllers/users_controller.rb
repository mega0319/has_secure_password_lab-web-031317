require 'pry'
class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:message] = "Passwords Do Not Match"
      redirect_to new_user_path and return
    elsif @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    end
  end

  def show
    authorize_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
