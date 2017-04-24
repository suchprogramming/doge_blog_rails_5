class Administration::CommentsController < ApplicationController
  before_action :authenticate_admin!

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_comment_update

  def update
    @comment = Comment.find(params[:id])
    authorize [:administration, @comment]
    if @comment.update(comment_params) && comment_flagged?(params)
      flash.now[:alert] = 'Comment flagged!'
    elsif @comment.update(comment_params) && !comment_flagged?(params)
      flash.now[:notice] = 'Comment activated!'
    else
      flash.now[:alert] = 'Error!'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:flagged)
  end

  def comment_flagged?(params = nil)
    return unless params

    return true if params[:comment][:flagged] == '1'
    return false if params[:comment][:flagged] == '0'
  end

  def unauthorized_comment_update
    flash.now[:alert] = 'You are not authorized to perform this action.' and render :update
  end
end
