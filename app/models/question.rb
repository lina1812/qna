class Question < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :author_questions
  belongs_to :best_answer, class_name: 'Answer', optional: true
  has_many :answers, dependent: :destroy
  has_many :other_answers, ->(question) { where.not(id: question.best_answer_id) }, class_name: 'Answer'

  validates :title, :body, presence: true
  
end
