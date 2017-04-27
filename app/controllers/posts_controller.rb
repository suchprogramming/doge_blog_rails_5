class PostsController < ApplicationController
  before_action :authenticate_any_scope!, except: [:index, :show]

  def index
    @posts = Post.active.filter(params.slice(:date_scope, :post_search))
      .page(params[:page]).order(created_at: 'desc')
  end

  def new
    @post = Post.new(postable: postable)
    authorize @post
  end

  def show
    @post = Post.find(params[:id])
    authorize @post
  end

  def create
    @post = current_any_scope.posts.new(post_params)
    authorize @post
    if @post.save
      redirect_to polymorphic_path([@post.postable, @post]), success: "Your new post has been created!"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update(post_params)
      redirect_to polymorphic_path([@post.postable, @post]), success: "Post successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    if @post.destroy
      redirect_to root_path, success: "Post successfully deleted!"
    else
      redirect_to root_path, alert: "An error has occured!"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :post_content, :active).merge(postable: postable)
  end

  def postable
    return User.find(params[:user_id]) if params[:user_id]
    return Admin.find(params[:admin_id]) if params[:admin_id]
  end
end
