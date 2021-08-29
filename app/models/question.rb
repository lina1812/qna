class Question < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :author_tests, optional: true
  has_many :answers, dependent: :destroy
  
  validates :title, :body, presence: true
  
end
