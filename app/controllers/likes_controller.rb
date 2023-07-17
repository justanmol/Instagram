class LikesController < ApplicationController
	before_action :authenticate_user
	before_action :set_like, only:[:destroy]

	def create
		prv_like = @current_user.likes.find_by(likeable_id: params[:like][:likeable_id], likeable_type: params[:like][:likeable_type])
		if prv_like
			render json: {error: "You Can't Like, because you've already done it"}
		else
			@like = @current_user.likes.new(like_params)
			if @like.save
				render json: @like, status: :created 
			else
				render json: @like.errors, status: :unprocessable_entity
			end
		end
	end
	

	def destroy
		@like = @current_user.likes.find(params[:id])
		if @like.destroy
			render json: {message: "Like Deleted"}
		else
			render json: {message: "Couldn't delete Like"}
		end
	end

	def index
		likes = @current_user.likes
		if likes.empty?
			render json: {error: "No Likes"}
		else
			render json: likes
		end
	end

	private

	def set_like
		@like = @current_user.likes.find(params[:id])
	rescue
		render json: { error: 'like not found' }, status: :not_found
	end

	def like_params
		params.require(:like).permit(:likeable_type, :likeable_id)
	end
end
  # before_action :authenticate_user, only: [:create]

  # def index
  # 	like = Like.all
  # 	render json: like
  # end

  # def create
  # 	post = Post.find(params[:id])
  # 	if post
  # 		likes = Like.new
  # 		likes.post_id = post.id
  # 		likes.save
  # 		render json: {message: "Liked Successful"}
  # 	else
  # 		render json: {message: 'No post with this ID'}
  # 	end
  # end
  

  # private
  # 	def like_params
  # 		params.permit(:post_id)
  # 	end
