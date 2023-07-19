class UserController < ApiController
	skip_before_action :authenticate_user, only: [:login,:signup]
	before_action :set_user, only: [:posts, :destroy, :follow]

	def login
		@user = User.find_by(user_params)
		if @user
			token = jwt_encode(user_id: @user.id)
			render json: {token: token}, status: :ok
		else
			render json: {error: 'login failed'}, status: :unauthorized
		end
	end

	def signup
    user = User.new(user_params)
    if user.save
      render json: { message: 'User Created Successfully '}, status: :created
    else
      render json: { error: user.error_messages }, status: :unprocessable_entity
    end
  end

  def follow
  	# byebug
  	# user = User.find_by(params[:id])
  	if @current_user.id == @user.id
  		render json: {error: 'you cannot follow'}
  	else
	  	following = Following.new(follower_id: @current_user.id, followee_id: @user.id)
	  	if following.save
	  		render json: following
	  	else
	  		render json: {error: 'not followed'}
	  	end
	 end
  end

  def unfollow
  	followee = Following.find_by(id:params[:id])
  	if followee.present?
	  	followee.destroy
	  	render json: {error: 'Unfollowed Successfully'}
	  else
	  	render json: {message: 'Please follow to unfollow'}
	  end
  end

  def destroy
  	if @user
  		@user.destroy
  		render json: {message: "Destroy Successfully"}
  	else
  		render json: {error: "Record not found"}
  	end
  end
 	
 	def posts
 		# byebug
 		if @user
 			@user.present?
			post =  @user.posts
			if post.present?
				render json: post
			else
				render json: {error: 'no post found'}
			end
		else
 			render json: {message: "No user found on this id"}
 		end
 	end
  
  private

  def user_params
    params.permit(:email, :password_digest)
  end

  def set_user
  	@user = User.find_by(id: params[:id])
  	render json:{ error: 'User not found' }, status: :not_found if @user.nil?
  end

end

