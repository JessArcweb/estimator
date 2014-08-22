class QuestionsController < ApplicationController
  respond_to :json

  def index
    @questions = Question.all.order(:index)
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
    @question.index = Question.all.count 
    if @question.save
      redirect_to questions_url
    else
      redirect_to root_url
    end
  end

  def update
    ids = params[:q]
    ids.each_with_index do |id, index|
      @q = Question.find(id)
      @q.index = index
      @q.save
    end

    #questions_by_id = Question.find(ids).index_by(&:id) # Gives you a hash indexed by ID
    #ids.collect {|id| questions_by_id[id] }
    #puts questions_by_id
    
    redirect_to questions_path
  end

  def destroy
    if @question = Question.find(params[:id])
      @question.destroy
      respond_to do |format| 
        format.html { redirect_to questions_path } 
      end
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  private

    def question_params
      params.require(:question).permit(:body, choices_attributes: [:id, :option, :value, :_destroy])
    end

end
