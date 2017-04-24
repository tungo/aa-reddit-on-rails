class PostsController < ApplicationController
  before_filter :require_login!, only: [:new, :create]
  before_action :require_author!, only: [:edit, :update, :destroy]
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

    @all_comments = @post.comments.includes(:author)
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
    @post = Post.find(params[:id])

    unless @post.destroy
      flash[:errors] = @post.errors.full_messages
    end

    redirect_to sub_url(@post.sub_id)
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def require_author!
    unless current_user.posts.ids.include?(params[:id].to_i)
      flash[:errors] = ['You have no permission to do this']
      redirect_to root_url
    end
  end
end
