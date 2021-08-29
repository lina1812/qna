class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :destroy]
  before_action :load_answer, only: [:show, :edit, :update, :destroy]
  before_action :find_question, only: %i[new create ]

  
  def show
  end
  
  def edit
  end
  
  
  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to @question, notice: 'Your answer successfully created.'
    else
      render template: "questions/show"
    end
  end
  
  def update
   if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end
  
  def destroy
    if @answer.author_id != current_user.id || current_user.nil?
      redirect_to question_path(@answer.question), notice: 'You can not delete not your answer.'
      else
      @answer.destroy
      redirect_to question_path(@answer.question), notice: 'Your answer was successfully deleted.'
    
    end
  end
    
  private
  

  def answer_params
    params.require(:answer).permit(:body)
  end
  
  def load_answer
    @answer = Answer.find(params[:id])
  end
  
  def find_question
    @question = Question.find(params[:question_id])
  end
end
