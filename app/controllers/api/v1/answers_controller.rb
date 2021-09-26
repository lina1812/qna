class Api::V1::AnswersController < Api::V1::BaseController
  skip_forgery_protection
  before_action :find_question, only: %i[create update destroy]
  def index
    @answers = Question.find(params[:question_id]).answers
    render json: @answers, include: ['author']
  end

  def show
    @answer = Question.find(params[:question_id]).answers.with_attached_files.find(params[:id])
    render json: @answer, include: ['files', 'links', 'author', 'comments', 'comments.author']
  end

  def create
    authorize Answer
    @answer = Answer.new(answer_params.merge(question: @question))
    @answer.author = current_resource_owner
    if @answer.save
      ActionCable.server.broadcast("question_#{@question.id}", { html: render_to_string(partial: 'answers/answer', locals: { answer: @answer }, formats: [:js]) })

      render json: @answer, include: ['author']
    else
      render json: { error: 'Your answer was not save' }
    end
  end

  def update
    @answer = Answer.find(params[:id])
    authorize @answer
    if @answer.update(answer_params)
      render json: @answer, include: ['author']
    else
      render json: { error: 'Your answer was not save' }
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    authorize @answer
    if @answer.destroy
      head :ok
    else
      render json: { error: 'Your question was not delete' }
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
