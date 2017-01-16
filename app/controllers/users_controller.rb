class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/#'
    else
      redirect_to '/login'
    end
  end

  # def profile
  #   @user = User.find(session[:user_id])
  #   @saves =
  # end

  # def edit
  #   @user = User.find(session[:user_id])
  #   @user.username = params[:user][:username]
  #   @user.save
  #   redirect_to '/profile'
  # end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
