class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authenticate_author!, except: [:show]

  # GET /posts
  def index
    @posts = current_author.posts.order(created_at: :desc)
    
  end

  # GET /posts/1
  def show
    @post = Post.published.friendly.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = current_author.posts.build
  end

  # GET /posts/1/edit
  def edit
    @element = @post.elements.build
  end

  # POST /posts
  def create
    @post = current_author.posts.build(post_params)

    if @post.save
      redirect_to edit_post_path(@post)
    else
      render edit_post_path(@post)
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to edit_post_path(@post)
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_author.posts.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :header_image)
    end
end
