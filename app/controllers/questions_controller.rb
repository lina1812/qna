class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit update destroy purge_file subscribe unsubscribe]

  def index
    authorize Question
    @questions = Question.all
  end

  def show
    authorize @question
    @answer = @question.answers.new
    @answer.links.new
  end

  def new
    authorize Question
    @question = Question.new
    @question.links.new
    @question.build_reward
  end

  def create
    authorize Question
    @question = Question.new(question_params)
    @question.author = current_user
    @question.subscriptions << current_user
    if @question.save
      ActionCable.server.broadcast('questions', { id: @question.id, title: @question.title })
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @question
    @question.update(question_params)
  end

  def destroy
    authorize @question
    @question.destroy
    redirect_to questions_path, notice: 'Your question was successfully deleted.'
  end
  
  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], reward_attributes: %i[name image], links_attributes: %i[name url _destroy])
  end
end
