class Api::V1::QuestionsController < Api::V1::BaseController
  skip_forgery_protection

  def index
    @questions = Question.all
    render json: @questions, include: %w[answers author]
  end

  def show
    @question = Question.with_attached_files.find(params[:id])
    render json: @question, include: ['files', 'links', 'answers', 'author', 'comments', 'comments.author']
  end

  def create
    authorize Question
    @question = Question.new(question_params)
    @question.author = current_resource_owner
    if @question.save
      ActionCable.server.broadcast('questions', { id: @question.id, title: @question.title })
      render json: @question, include: ['author']
    else
      render json: { error: 'Your question was not save' }
    end
  end

  def update
    @question = Question.find(params[:id])
    authorize @question
    if @question.update(question_params)
      render json: @question, include: ['author']
    else
      render json: { error: 'Your question was not save' }
    end
  end

  def destroy
    @question = Question.find(params[:id])
    authorize @question
    if @question.destroy
      head :ok
    else
      render json: { error: 'Your question was not delete' }
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, reward_attributes: %i[name image], links_attributes: %i[name url _destroy])
  end
end
