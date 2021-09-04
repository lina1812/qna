class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: %i[update destroy mark_as_best]
  before_action :find_question, only: %i[create]

  def create
    @answer = Answer.create(answer_params.merge(question: @question, author: current_user))
  end

  def update
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      @question = @answer.question
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      @question = @answer.question
    end
  end

  def mark_as_best
    @question = @answer.question
    @question.update(best_answer_id: @answer.id)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: %i[name url])
  end

  def load_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end
end
