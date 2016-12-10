class CommentsController < ApplicationController
  def new
    @post_id = params[:id]
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:id]

    if @comment.save
      redirect_to post_url(Post.find(params[:id]))
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_post_comment_url(Post.find(params[:id]))
    end
  end

  def show
    #will redirect to create
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
