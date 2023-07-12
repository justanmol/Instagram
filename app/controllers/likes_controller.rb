class LikesController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
  	# byebug
  	post = Post.find_by(id: params[:post_id])
  	if post.nil?
  		render json: {message: 'No post with this ID'}
  	else
  		post.like += 1
  		post.save
  		render json: {message: "Liked Successful"}
  	end

	 end
  

  private
  	def like_params
  		params.permit(:post_id, :user_id)
  	end
end