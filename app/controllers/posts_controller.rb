# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :load_post, only: %i[edit destroy update]
  # layout 'editor', only: %i[new edit create update]

  def index
    @top = Post.all.limit(2)
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.publish
      redirect_to @post, notice: 'Successfully published the post!'
    else
      @post.unpublish
      flash.now[:alert] = 'Could not update the post, Please try again'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    #           @responses = @post.responses.includes(:user)
    @related_posts = @post.related_posts

    set_meta_tags @post.meta_info

    # If an old id or a numeric id was used to find the record, then
    # the request path will not match the post_path, and we should do
    # a 301 redirect that uses the current friendly id.
    redirect_to @post, status: 301 if request.path != post_path(@post)
  end

  def edit; end

  def update
    @post.assign_attributes(post_params)

    if @post.publish
      redirect_to @post, notice: 'Successfully published the post!'
    else
      @post.unpublish
      flash.now[:alert] = 'Could not update the post, Please try again'
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url, notice: 'Successfully deleted the post'
  end

  private

  def validate_captcha
    verify_recaptcha(action: 'post', minimum_score: 0.5, model: @post)
  end

  def post_params
    params.require(:post).permit(:title, :body, :all_tags, :image, :meta_keywords,
                                 :meta_description, :language, :lead)
  end

  def load_post
    @post = current_user.posts.find(params[:id])
  end
end
