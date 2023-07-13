class LikesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_like

	def create
		@like = current_user.likes.build(like_params)
		if @like.save
			render json: @like, status: :created 
		else
			render json: @like.errors, status: :unprocessable_entity
		end
	end
	
	def update
		if @like.update(like_params)
			render json: @like 
		else
			render json: @like.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@like = current_user.likes.find(params[:id])
		@like.destroy head :no_content
	end

	private

	def set_like
		@like = current_user.likes.find(params[:id])
	rescue ActiveRecord::RecordNotFound
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
