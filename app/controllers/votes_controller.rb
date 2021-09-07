class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @vote = Vote.new(vote_params.merge(user: current_user))
    if !current_user.author_of?(@vote.votable)
      @vote.save!
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy if current_user == @vote.user
  end

  def vote_params
    params.require(:vote).permit(:value, :votable_id, :votable_type)
  end
  
end
