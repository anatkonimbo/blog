class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    fname = params[:comment][:fullname].split(" ")[0]
    lname = params[:comment][:fullname].split(" ")[1]
    @comment = @post.comments.new(params[:comment].permit(:body, :tel, :rate))
    @comment.name = fname
    @comment.lastname = lname

    # @comment = @post.comments.create(params[:comment].permit(:name, :lastname, :body, :tel))

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end

  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post)
  end
end
