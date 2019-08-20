class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
  end

  def create
    @post = Post.create(post_params)
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end


end