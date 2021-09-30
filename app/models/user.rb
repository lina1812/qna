class User < ApplicationRecord
  has_many :author_questions, class_name: 'Question', inverse_of: :author, foreign_key: :author_id, dependent: :nullify
  has_many :author_answers, class_name: 'Answer', inverse_of: :author, foreign_key: :author_id, dependent: :nullify
  has_many :author_votes, class_name: 'Vote', inverse_of: :author, foreign_key: :author_id, dependent: :destroy
  has_many :author_comments, class_name: 'Comment', inverse_of: :author, foreign_key: :author_id, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :best_answers, -> { joins(:question).where('answers.id = questions.best_answer_id') }, class_name: 'Answer', foreign_key: :author_id
  has_many :best_questions, source: :question, through: :best_answers
  has_many :rewards, through: :best_questions
  has_many :authorizations, dependent: :destroy
  has_many :user_subscriptions, dependent: :destroy
  has_many :subscription_questions, source: :question, through: :user_subscriptions
  # has_and_belongs_to_many :subscription_questions, class_name: 'Question'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[github facebook google_oauth2]

  def vote_for(votable)
    author_votes.where(votable: votable).first
  end

  def self.find_for_oauth(auth)
    FindForOauth.new(auth).call
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
