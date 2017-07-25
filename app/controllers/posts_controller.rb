class PostsController < ApplicationController
PER_PAGE = 2
  def index
      @posts = Post.order("title")
      @posts = @posts.search(params[:search])
      @posts = Post.order("title").page(params[:page]).per_page(PER_PAGE)

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
    # @post.calculate_number_of_words

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
    # @post.calculate_number_of_words

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


private

  def post_params
    params.require(:post).permit(:title, :tags, :body, :amount, :avr_rates, :photo, :email)
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "anat" && password == "konimbo"
    end
  end
end
