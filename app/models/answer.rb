class Answer < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :author_answers, optional: true
  belongs_to :question

  validates :body, presence: true
end
