class Answer < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :author_answers
  belongs_to :question
  
  has_many_attached :files

  validates :body, presence: true
end
