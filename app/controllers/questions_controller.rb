class QuestionsController < ApplicationController
  respond_to :json

  def index
    @questions = Question.all
    @new_question = Question.new

    respond_to do |format|
      format.html
      format.json { render :json => @questions.as_json(:include => :choices) }
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_url
    else
      redirect_to root_url
    end
  end

  private

    def question_params
      params.require(:question).permit(:body, choices_attributes: [:id, :option, :value, :_destroy])
    end

end
