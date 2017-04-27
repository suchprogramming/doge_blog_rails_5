class Administration::PostsController < ApplicationController
  before_action :authenticate_admin!

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_post_update

  def update
    authorize [:administration, @post]
  end

  private

  def post_params
    params.require(:post).permit(:active)
  end

  def unauthorized_post_update
    flash.now[:alert] = 'You are not authorized to perform this action.' and render :show
  end
end
