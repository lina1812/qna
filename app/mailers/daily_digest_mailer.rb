class DailyDigestMailer < ApplicationMailer
  def digest(user)
    @questions = Question.where("created_at > ?", Time.now - 86400)
    mail to: user.email
  end
end
  