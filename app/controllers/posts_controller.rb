class PostsController < ApplicationController
  before_action :require_login!, only: [:new, :create, :edit, :update]
  before_action :require_author!, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = 1

    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    if current_user
      @is_author = current_user.id == @post.author_id
    else
      @is_author = false
    end
    render :show
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def require_author!
    @post = Post.find(params[:id])
    unless current_user.id == @post.author_id
      flash[:errors] = ["Must be author to edit."]
      redirect_to post_url(@post)
    end
  end
end
