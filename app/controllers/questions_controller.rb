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

  def edit
  end

  def update
    #ids = params[:q]
    #ids.each_with_index do |id, index|
      #@q = Question.find(id)
      #@q.index = index
      #@q.save
    #end
    #
    @question = Question.find(params[:id])
    body = params[:question][:body]
    choices_attributes = params[:question][:choices_attributes]
    @question.update_attributes(:body => body, :choices_attributes => choices_attributes)

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

  def next
    @current_question = Question.find(params[:id])
    if @current_question.index < Question.all.count - 1
      @next_question = Question.where(:index => @current_question.index + 1)
    else
      @next_question = nil
    end

    puts @next_question.inspect

    respond_to do |format|
      format.json { render :json => @next_question.as_json(:include => :choices) }
    end
    redirect_to ''
  end

  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @question.as_json(:include => :choices) }
    end
  end

  private

    def question_params
      params.require(:question).permit(:body, choices_attributes: [:id, :option, :value, :_destroy])
    end

end
