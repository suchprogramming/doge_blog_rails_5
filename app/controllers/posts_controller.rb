class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new(user_id: params[:user_id])
    authorize @post
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.new(post_params)
    authorize @post
    if @post.save
      redirect_to post_path(@post), success: "Your new post has been created!"
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
      redirect_to post_path(@post), success: "Post successfully updated!"
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
    params.require(:post).permit(:title, :post_content)
  end

end
