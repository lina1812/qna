class SubscriptionMailer < ApplicationMailer
  def notification(question, answer, user)
    @question = question
    @answer = answer
    mail to: user.email
  end
end
