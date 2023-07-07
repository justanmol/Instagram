class LikesController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
  	post = Post.find(params[:id])
  	if post.nil?
  		render json: {message: 'No post with this ID'}
  	else
  		post.like += 1
  		render json: {message: "Liked Successful"}
  	end

  	# byebug
    # # post = Post.find(params[:id])
    # @like = Like.new(like_params)

	  # # if Like.where(post_id: like.post_id)  
	  # #   render json: { messasge: 'Yoh have liked this post. So, you cannot like again'}
	  # # else
	  #   if @like.save
	  #     render json: @like, status: :created
	  #   else
	  #     render json: { error: @like.errors.full_messages }, status: :unprocessable_entity
	  #   end
	 end
  

  private
  	def like_params
  		params.permit(:post_id, :user_id)
  	end
end