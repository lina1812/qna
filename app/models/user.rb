class User < ApplicationRecord
  has_many :author_questions, class_name: 'Question', inverse_of: :author, foreign_key: :author_id, dependent: :nullify
  has_many :author_answers, class_name: 'Answer', inverse_of: :author, foreign_key: :author_id, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :best_answers, -> { joins(:question).where("answers.id = questions.best_answer_id") }, class_name: 'Answer', foreign_key: :author_id
  has_many :best_questions, source: :question, through: :best_answers
  has_many :rewards, through: :best_questions
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def author_of?(object)
    id == object.author_id
  end
end
