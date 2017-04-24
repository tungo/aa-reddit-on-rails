class PostsController < ApplicationController
  before_filter :require_login!, only: [:new, :create]
  before_action :require_author!, only: [:edit, :update]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end

  def require_author
    if
  end
end
