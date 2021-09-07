class Answer < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :author_answers
  belongs_to :question

  has_many :links, dependent: :destroy, as: :linkable
  has_many :votes, dependent: :destroy, as: :votable

  accepts_nested_attributes_for :links, reject_if: :all_blank

  has_many_attached :files

  validates :body, presence: true
  
  def score
    votes.sum(:value)  
  end
  
end
