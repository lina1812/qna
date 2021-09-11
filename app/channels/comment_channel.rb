class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comment_#{params[:id]}"
  end
end
