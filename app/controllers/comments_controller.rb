class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment].permit(:body, :tel, :rate, :fullname))

    if @comment.save
      PostMailer.new_comment(@post).deliver
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update_attributes(params[:comment].permit(:body, :tel,:showCom, :rate))
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post)
  end


end
