class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment].permit(:body, :tel, :rates, :full_name))

    if @comment.save
      PostMailer.new_comment(@post).deliver
      
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js
      end
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

    if @comment.update_attributes(params[:comment].permit(:body, :tel,:show_comment, :rates))
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
