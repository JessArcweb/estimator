class SurveyController < ApplicationController
    before_filter :check_for_mobile, :only => :index
	def index
	end
end
