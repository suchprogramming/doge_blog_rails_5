class Administration::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @post = Post.find(params[:post_id])
    @commentable = poly_params
    @comment = Comment.find(params[:comment_id])
    flash.now[:notice] = 'Comment flagged!' if @comment.update(comment_params)
  end

  private

  def comment_params
    params.require(:comment).permit(:flagged)
  end

  def poly_params
    return User.find(params[:user_id]) if params[:user_id]
    return Admin.find(params[:admin_id]) if params[:admin_id]
    {}
  end

end
