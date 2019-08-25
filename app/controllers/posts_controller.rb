class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :delete]

  def update
    @post = Post.find_by_id(params[:id])
    return render_not_found if @post.blank?

    @post.update_attributes(post_params)

    if @post.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def new
    @post = Post.new
  end

  def index
  end

  def show
    @post = Post.find_by_id(params[:id])
    return render_not_found if @post.blank?
  end

  def edit
    @post = Post.find_by_id(params[:id])
    return render_not_found if @post.blank?
    end

  def create
    @post = current_user.posts.create(post_params)
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

  def render_not_found
    render plain: 'Not Found :(', status: :not_found
  end

end