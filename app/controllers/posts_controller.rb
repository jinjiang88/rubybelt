class PostsController < ApplicationController
  def index
  	@posts = Post.all
    # @posts = Post.joins(:likes).group(:post_id).order("count_all DESC").count
    @user = User.find(session[:user_id])
  end
  def create
    post = Post.new post_params
    unless post.save
      flash[:errors] = post.errors.full_messages
    end
    redirect_to "/posts"
  end
  def show
  	@post = Post.find(params[:id])
  	@likes = @post.likes
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy if @post.user === current_user
    redirect_to "/posts"
  end
  private
    def post_params
      params.require(:post).permit(:content).merge(user: current_user)
    end
end
