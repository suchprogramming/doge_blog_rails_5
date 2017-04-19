class CommentsController < ApplicationController
  before_action :authenticate_any_scope!

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_comment

  def new
    @post = Post.find(params[:post_id])
    @comment = commentable.comments.new
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    authorize @comment
    if @comment.save
      params[:page] = @post.comments.page.total_pages
      flash.now[:success] = "Comment created!"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.update(comment_params)
      flash.now[:success] = 'Comment updated!'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize @comment
    flash.now[:success] = 'Comment removed!' if @comment.destroy
    params[:page] = @comment.page_num
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(commentable: commentable, post: @post)
  end

  def commentable
    return User.find(params[:user_id]) if params[:user_id]
    return Admin.find(params[:admin_id]) if params[:admin_id]
  end

  def unauthorized_comment
    flash.now[:alert] = 'You are not authorized to perform this action.' and render :error
  end
end
