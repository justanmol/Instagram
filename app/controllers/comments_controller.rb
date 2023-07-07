class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    post = Post.find(params[:post_id])
    # comment = @current_user.comments.new(comment_params.merge(post: post))
        comment = @current_user.post.comments.new(params[:content]))
    if comment.save
      render json: comment, status: :created
    else
      render json: { error: "Comment Failed" }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.permit(:content)
  end
end