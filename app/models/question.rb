class Question < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :author_questions
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_one :reward, dependent: :destroy
  
  has_many :answers, dependent: :destroy
  has_many :other_answers, ->(question) { where.not(id: question.best_answer_id) }, class_name: 'Answer'
  has_many :links, dependent: :destroy, as: :linkable

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :reward, reject_if: :all_blank

  has_many_attached :files
  
  validates :title, :body, presence: true
end
