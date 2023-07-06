class UserController < ApplicationController
	skip_before_action :authenticate_user

	def index
	end

	def show
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
end
