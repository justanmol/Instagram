# require 'byebug'
class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_post, only: [:show, :update, :destroy]
  
 	# def index
 	# 	post = Post.all
 	# 	render json: post
 	# end

 	def index
 		@user = current_user
 		@posts = @user.Posts
 		render json: @Posts
 	end

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
  		render json: {error: "record not found"}
  	end
	end
  
  private

  def set_post
  	@post = current_user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
  	render json:{ error: 'Post not found' }, status: :not_found
  end

  def post_params
    params.permit(:content, :post)
  end
end