class Answer < ApplicationRecord
  include Votable
  belongs_to :author, class_name: 'User', inverse_of: :author_answers
  belongs_to :question

  has_many :links, dependent: :destroy, as: :linkable
  has_many :comments, dependent: :destroy, as: :commentable

  accepts_nested_attributes_for :links, reject_if: :all_blank

  has_many_attached :files

  validates :body, presence: true

  after_create :add_user_to_subscription_question

  private

  def add_user_to_subscription_question
    SubscriptionJob.perform_now(id)
  end
end
