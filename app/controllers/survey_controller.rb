class SurveyController < ApplicationController
    before_filter :prepare_for_mobile, :only => :index
	def index
	end
end
