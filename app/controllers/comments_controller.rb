class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    fname = params[:comment][:fullname].split(" ")[0]
    lname = params[:comment][:fullname].split(" ")[1]
    @comment = @post.comments.new(params[:comment].permit(:body, :tel, :rate, :showCom))
    @comment.name = fname
    @comment.lastname = lname

    if @comment.save
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

    if @comment.update_attributes(params[:comment].permit(:body, :tel, :rate, :showCom))
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


  def showcomment
    debugger
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.update_all({showCom: true}, {id: params[:comment_ids]})
    redirect_to post_path(@post)
  end


end
