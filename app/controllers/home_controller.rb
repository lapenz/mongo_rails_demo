class HomeController < ApplicationController
  before_action :set_post, only: [:show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order('desc created_at').page params[:page]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

end
