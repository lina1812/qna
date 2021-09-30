class Subscription
  def send_notification(question, answer)
    User.joins(:subscription_questions).where(questions: { id: question.id }).each do |user|
      SubscriptionMailer.notification(question, answer, user).deliver_later
    end
  end
end
