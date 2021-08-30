class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_answer, only: %i[show edit update destroy]
  before_action :find_question, only: %i[new create]

  def edit; end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.author = current_user
    if @answer.save
      redirect_to @question, notice: 'Your answer successfully created.'
    else
      render 'questions/show'
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
    if current_user.author_of?(@answer)
      @answer.destroy
      redirect_to question_path(@answer.question), notice: 'Your answer was successfully deleted.'
    else
      redirect_to question_path(@answer.question), notice: 'You can not delete not your answer.'
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
