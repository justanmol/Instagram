class ApiController < ActionController::API
		include JsonWebToken

		before_action do
	    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
	  end

		before_action :authenticate_user

		private
		  def authenticate_user
		  	begin
			    header = request.headers['Authorization']
			    header = header.split(" ").last if header
			    decoded = jwt_decode(header)
			    @current_user = User.find(decoded[:user_id])
			  rescue
			  	render json: { message: 'Please generate Token First'}
			  end
		  end
end
