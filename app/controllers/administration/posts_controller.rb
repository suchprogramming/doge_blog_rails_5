class Administration::PostsController < ApplicationController
  before_action :authenticate_admin!

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_post_update

  def update
    @post = Post.find(params[:id])
    authorize [:administration, @post]
    if @post.update(post_params) && !post_activated?(params)
      flash.now[:alert] = 'Post deactivated!'
    elsif @post.update(post_params) && post_activated?(params)
      flash.now[:notice] = 'Post activated!'
    else
      flash.now[:alert] = 'Error!'
    end
  end

  private

  def post_activated?(params = nil)
    return unless params

    return true if params[:post][:active] == '1'
    return false if params[:post][:active] == '0'
  end

  def post_params
    params.require(:post).permit(:active)
  end

  def unauthorized_post_update
    flash.now[:alert] = 'You are not authorized to perform this action.' and render :update
  end
end
