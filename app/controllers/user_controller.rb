class UserController < ApplicationController
	skip_before_action :authenticate_user, only: [:login,:signup]

	def index
 		@posts = Post.all
  	arr = []
  	@posts.each do |i|
  		h = Hash.new
  		h[:user_id] = i.user_id
  		h[:content] = i.content
  		h[:post_id] = i.id
  		h[:post] = i.post.url
  		h[:like] = i.like

  		arr.push(h)
  	end
  	render json: arr
	end

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
      # token = JsonWebToken.encode(user_id: @user.id)
      render json: { message: 'User Created Successfully '}, status: :created
    else
      render json: { error: user.error_messages }, status: :unprocessable_entity
    end
  end



  private

  def user_params
    params.permit(:email, :password_digest)
  end
end

