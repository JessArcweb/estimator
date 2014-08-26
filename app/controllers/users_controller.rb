class UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def index
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
        @estimate = params[:estimate]
		if @user.save and params[:report] == true
          NotifyMailer.notify(@user).deliver
          NotifyMailer.report(@user).deliver
		  redirect_to root_url
		else
			redirect_to "#"
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :newsletter, :report, :estimate, :answers => [])
		end
end
