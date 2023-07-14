class UserController < ApplicationController
	skip_before_action :authenticate_user, only: [:login,:signup]

	def login
		@user = User.find_by(email: params[:email], password_digest: params[:password_digest])
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
  	@user = User.find(params[:id])
  	current_user.followees << @user 
  	head :no_content
  end

  def unfollow
  	@user = User.find(params[:id])
  	current_user.followees.delete(@user)
  	head :no_content
  end

  def destroy
  	user = User.find(params[:id])
  	if user
  		user.destroy
  		render json: {message: "Destroy Successfully"}
  	else
  		render json: {error: "Record not found"}
  	end
  end
 	
 	def posts
 		# byebug
 		user = User.find_by(id: params[:id])
 		if user.present?
			post =  user.posts
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
end

