# require 'byebug'
class PostsController < ApiController
	before_action :authenticate_user
	before_action :set_post, only: [:show, :update, :destroy]

 	def index
 		followee_ids = @current_user.followees.pluck(:id)
 		@posts = Post.where(user_id: followee_ids)
 		render json: @posts 
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
  	# post = @current_user.posts.find(params[:id])
  	if @post
  		@post.destroy
  		render json: {message: "Destroy Successfully"}
  	else
  		render json: {error: "record not found"}
  	end
	end

	def update
		content = params[:content] ? params[:content] : @post.content
		# content = params[:content] ? params[:content] : @post.content
		 if @post.update(content: content)
		 	render json: {message: "Post Updated"}
		 end
	end
  
  private

  def set_post
  	@post = @current_user.posts.find(params[:id])
  	render json:{ error: 'Post not found' }, status: :not_found if @user.nil?
  end

  def post_params
    params.permit(:content, :post)
  end
end