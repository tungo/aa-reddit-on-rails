class PostsController < ApplicationController
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
  end

  def destroy
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
