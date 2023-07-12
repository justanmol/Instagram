require 'byebug'
class PostsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index]
  
  def create
    @post = @current_user.posts.new(post_params)
    @post.post.attach(params[:post])
   	@post.like = 0 
    if @post.save
	    render json: {message: "Post Is Created #{@post.post.url}" }, status: :created
		else
      render json: { error: "Post is not Created "}, status: :unprocessable_entity
    end
  end

  def destroy
  	post = Post.find(params[:id])
  	if post
  		post.destroy
  		render json: {message: "Destroy Successfully"}
  	else
  		render json: {error: "r "}
  	end
	end
  private

  def post_params
    params.permit(:content, :post)
  end
end