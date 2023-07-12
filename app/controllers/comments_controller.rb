class CommentsController < ApplicationController
  before_action :authenticate_user

  def index
  	comment = Comment.all
  	render json: comment
  end

  def show
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: { error: "Comment Failed" }, status: :unprocessable_entity
    end
  end

  def destroy
  	comment = Comment.find(params[:id])
  	if comment
  		comment.destroy
  		render json: {message: "Destroy Successfully"}
  	end
  	rescue
  		render json: {error: "record not found"}
  end

  private
  def comment_params
    params.permit(:content, :post_id)
  end
end