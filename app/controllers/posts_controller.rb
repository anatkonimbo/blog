class PostsController < ApplicationController
PER_PAGE = 5

  def index
      @posts = Post.order(params["options_order"]).page(params[:page]).per_page(PER_PAGE).search(params[:search])

      respond_to do |format|
        format.html
        format.json {
          render :json => @posts.to_json( :include => [:comments] )
        }
        format.xml {
          render :xml => @posts.to_xml( :include => [:comments] )
        }
      end
  end

  def new
    @post = Post.new

  end

  def show
    @post = Post.find(params[:id])
    @post.average_rate

    respond_to do |format|
      format.html
    	format.json {
        render :json => @post.to_json( :include => [:comments] )
      }
      format.xml {
        render :xml => @post.to_xml( :include => [:comments] )
      }
    end

  end


  def create
    @post = Post.new(post_params)

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

    if @post.update_attributes(params[:post].permit(:title, :tags, :body, :amount, :avr_rates, :photo, :email))
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

  def change_language
    I18n.locale = 'he' || I18n.default_locale

    redirect_to :back
  end

private

  def post_params
    params.require(:post).permit(:title, :tags, :body, :amount, :avr_rates, :photo, :email)
  end

end
