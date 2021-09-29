class SubscriptionJob < ApplicationJob
  queue_as :default

  def perform(answer_id)
    answer = Answer.find(answer_id)
    question = Question.where(answers: answer).first
    Subscription.new.send_notification(question, answer)
  end
end
