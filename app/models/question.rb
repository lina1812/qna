class Question < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :author_questions
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true
end
