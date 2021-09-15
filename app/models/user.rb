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
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  def author_of?(object)
    id == object.author_id
  end

  def vote_for(votable)
    author_votes.where(votable: votable).first
  end
  
  def self.find_for_oauth(auth)
    Services::FindForOauth.new(auth).call
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
