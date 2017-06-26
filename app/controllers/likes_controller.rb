class LikesController < ApplicationController

  def create
    Like.create like_params
    redirect_to "/posts"
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy if current_user === @like.user
    redirect_to "/posts"    
  end

  private
    def like_params
      params.require(:like).permit(:post_id).merge(user: current_user)
    end
end
