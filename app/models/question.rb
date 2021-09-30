class Question < ApplicationRecord
  include Votable
  belongs_to :author, class_name: 'User', inverse_of: :author_questions
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_one :reward, dependent: :destroy

  has_many :answers, dependent: :destroy
  has_many :other_answers, ->(question) { where.not(id: question.best_answer_id) }, class_name: 'Answer'
  has_many :links, dependent: :destroy, as: :linkable
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :user_subscriptions, dependent: :destroy
  has_many :subscriptions, source: :user, through: :user_subscriptions

  # has_and_belongs_to_many :subscriptions, class_name: 'User'

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :reward, reject_if: :all_blank

  has_many_attached :files

  validates :title, :body, presence: true

  after_create :add_author_to_subscription_question

  private

  def calculate_reputation
    ReputationJob.perform_later(self)
  end

  def add_author_to_subscription_question
    subscriptions << author
  end
end
