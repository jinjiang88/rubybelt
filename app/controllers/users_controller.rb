class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
  end
  def create
    @user = User.new user_params
    if @user.save
        session[:user_id] = @user.id
        redirect_to "/posts"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end
  def show
    @user = User.find(params[:id])
  end

  private
   	def user_params
      params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
    end
end
