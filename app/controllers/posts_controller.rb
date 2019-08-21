class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
  end

  def create
    @post = Post.create(post_params)
    if @post.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:message)
  end
  
end