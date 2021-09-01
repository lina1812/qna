class Question < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :author_questions
  belongs_to :best_answer, class_name: 'Answer', optional: true
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true
  
  def other_answers
    answers.where.not(id: best_answer_id)
  end
end
