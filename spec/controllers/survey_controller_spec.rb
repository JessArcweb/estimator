require "spec_helper"

describe SurveyController do
  describe "GET #index" do
    it "should render the :index view" do
      get :index
      response.should render_template :index
    end
  end
end
