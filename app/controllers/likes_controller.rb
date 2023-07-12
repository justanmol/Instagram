class LikesController < ApplicationController
  before_action :authenticate_user, only: [:create]

  def index
  	like = Like.all
  	render json: like
  end

  def create
  	post = Post.find(params[:id])
  	if post
  		likes = Like.new
  		likes.post_id = post.id
  		likes.save
  		render json: {message: "Liked Successful"}
  	else
  		render json: {message: 'No post with this ID'}
  	end
  end
  

  private
  	def like_params
  		params.permit(:post_id)
  	end
end