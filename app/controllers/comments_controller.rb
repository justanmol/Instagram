class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :set_comment, only: [:update, :destroy]
  
  def create
  	@comment = @current_user.comments.new(comment_params)
  	if @comment.save
  		render json: @comment, status: :created
  	else
  		render json: @comment.errors, status: :unprocessable_entity
  	end
  end

  def update
  	# byebug
  	if @comment
	  	# post = Post.where(id: params[:post_id])
 
  	# if @comment
  		@comment.update(comment_params)
  		render json: @comment
  	end
  end

  def destroy
  	# @comment = @current_user.comments.find(params[:id])
  	if @comment.destroy
  		render json: {message: "Comment Deleted"}
  	else
  		render json: {error: "Couldn't delete comment"}
  	end
  end

  def index
  	comments = @current_user.comments
    if comments.empty?
      render json:{error: "No Comment"}
    else
  	 render json: comments
    end
  end

  private

  def set_comment
  	# @comment = @current_user.comments.find(params[:id])
  	@comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
  	render json: { error: 'Comment not found' }, status: :not_found
  end

  def comment_params
  	params.permit(:post_id, :content)
  end
end

#   def index
#   	comment = Comment.all
#   	render json: comment
#   end

#   def show
#   end

#   def create
#     post = Post.find(params[:post_id])
#     comment = post.comments.new(comment_params)
#     if comment.save
#       render json: comment, status: :created
#     else
#       render json: { error: "Comment Failed" }, status: :unprocessable_entity
#     end
#   end

#   def destroy
#   	comment = Comment.find(params[:id])
#   	if comment
#   		comment.destroy
#   		render json: {message: "Destroy Successfully"}
#   	end
#   	rescue
#   		render json: {error: "record not found"}
#   end

#   private
#   def comment_params
#     params.permit(:content, :post_id)
#   end
# end