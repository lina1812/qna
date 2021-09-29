class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: %i[update destroy mark_as_best]
  before_action :find_question, only: %i[create]

  def create
    authorize Answer
    @answer = Answer.new(answer_params.merge(question: @question, author: current_user))
    if @answer.save
      ActionCable.server.broadcast("question_#{@question.id}", { html: render_to_string(partial: 'answers/answer', locals: { answer: @answer }) })
      SubscriptionJob.perform_now(@answer.id)
    end
  end

  def update
    authorize @answer
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    authorize @answer
    @answer.destroy
    @question = @answer.question
  end

  def mark_as_best
    authorize @answer
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
