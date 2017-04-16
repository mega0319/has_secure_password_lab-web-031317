class SessionsController < ApplicationController

def new
end

def create
  @user = User.find_by(name: params[:user][:name])
  if @user && @user.authenticate(params[:user][:password])
    @user.save
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  else
    flash[:message] = "PASSWORD WAS INCORRECT"
    redirect_to login_path
  end
end

def destroy
  session.delete :name
  redirect_to login_path
end


end
