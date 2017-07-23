class PostsController < ApplicationController

  def index
      # @posts = Post.all
      # @post.average_rate
      @posts = Post.order("title").page(params[:page]).per_page(2)
  end

  def new
    @post = Post.new

  end

  def show
    @post = Post.find(params[:id])
    @post.average_rate
  end


  def create
    @post = Post.new(post_params)
    @post.calcu

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end


  def update
    @post = Post.find(params[:id])
    @post.calcu

    if @post.update_attributes(params[:post].permit(:title, :tags, :body, :amount, :avrRate))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end


  private
  def post_params
    params.require(:post).permit(:title, :tags, :body, :amount, :avrRate)
  end
end
