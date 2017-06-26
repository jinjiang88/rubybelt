class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
    def create
        @user = User.find_by_email(params[:email])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to "/posts"
      else 
          flash[:errors] = ["Invalid Combination"]
          redirect_to "/users/new"
      end
  end
    def destroy
        reset_session
        redirect_to "/users/new"
    end
end
