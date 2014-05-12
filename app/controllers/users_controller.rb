class UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
	end

	def new
		@user = User.new
	end

	def create
    logger.debug "params: " + params.to_s
		@user = User.new(user_params)
		if @user.save
			redirect_to root_url
		else
			redirect_to "#"
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, {:answers => []})
		end
end
