class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    question = Question.find(params[:question_id])
    UserSubscription.create(user: current_user, question: question)
    redirect_to question_path(question)
  end

  def destroy
    question = Question.find(params[:id])
    subscription = question.user_subscriptions.where(user: current_user).first
    subscription.destroy
    redirect_to question_path(question)
  end
 end
