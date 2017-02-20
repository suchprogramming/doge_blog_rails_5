class CommentsController < ApplicationController
  before_action :authenticate_any_scope!

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_comment

  def new
    @post = Post.find(params[:post_id])
    @commentable = poly_params
    @comment = @commentable.comments.new(post_id: @post.id)
    authorize @comment
  end

  def create
    @post = Post.find(params[:post_id])
    @commentable = poly_params
    @comment = @commentable.comments.new(comment_params.merge(post_id: @post.id))
    authorize @comment
    if @comment.save
      flash.now[:success] = "Comment created!"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @commentable = poly_params
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @post = Post.find(params[:post_id])
    @commentable = poly_params
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
    @commentable = poly_params
    @comment = Comment.find(params[:id])
    authorize @comment
    flash.now[:success] = 'Comment removed!' if @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def poly_params
    return User.find(params[:user_id]) if params[:user_id]
    return Admin.find(params[:admin_id]) if params[:admin_id]
    {}
  end

  def unauthorized_comment
    flash.now[:alert] = 'You are not authorized to perform this action.' and render :error
  end

end
