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
        if @user.save and params[:subscribe] == true
          uri = URI.parse("http://arcweb.us5.list-manage1.com/subscribe/post?u=8515671b9bcd64938e083a5cf&amp;id=bde3b116b4")
          http = Net::HTTP.new(uri.host, uri.port)

          request = Net::HTTP::Post.new(uri.request_uri)
          request.set_form_data({"EMAIL" => "#{@user.email}"})

          response = http.request(request)
        end
		if @user.save and params[:report] == true
          NotifyMailer.notify(@user).deliver
          NotifyMailer.report(@user).deliver
		  redirect_to root_url
		end

		redirect_to "#"
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :newsletter, :report, :estimate, :answers => [])
		end
end
