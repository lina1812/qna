class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params.merge(author: current_user, commentable: commentable))
    if @comment.save
      ActionCable.server.broadcast("comment_#{@comment.commentable_type}_#{@comment.commentable_id}",
                                   { html: render_to_string(partial: 'comments/comment', locals: { comment: @comment }) })
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end

  def commentable
    if params[:question_id]
      Question.find(params[:question_id])
    elsif params[:answer_id]
      Answer.find(params[:answer_id])
    end
  end
end
