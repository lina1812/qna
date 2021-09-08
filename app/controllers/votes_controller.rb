class VotesController < ApplicationController
  before_action :authenticate_user!
  
  

  def create
    @vote = Vote.new(vote_params.merge(author: current_user, votable: votable))
    if !current_user.author_of?(@vote.votable)
      if @vote.save
        render json: @vote
      else
        render json: {errors: @vote.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {errors: ['You can not vote for your record']}, status: :unprocessable_entity
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy if current_user.author_of?(@vote)
  end
  
  private

  def vote_params
    params.require(:vote).permit(:value)
  end
  
  def votable 
    if params[:question_id]
      Question.find(params[:question_id])
    elsif params[:answer_id]
      Answer.find(params[:answer_id])
    end
  end
  
end
