class VotesController < ApplicationController
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_vote

  def create
    @post = Post.find(params[:post_id])
    @vote = @post.votes.where(user_id: params[:user_id]).first_or_initialize(vote_params)
    authorize @vote

    flash.now[:success] = 'Voted!' and return if @vote.new_record? && @vote.save
    flash.now[:notice] = 'Already voted!' and return if @vote.direction == params[:vote][:direction]
    flash.now[:success] = 'Updated!' and return if @vote.update(vote_params)
  end

  private

  def vote_params
    params.require(:vote).permit(:direction)
  end

  def unauthorized_vote
    flash.now[:alert] = 'You are not authorized to perform this action.' and render :create
  end

end
