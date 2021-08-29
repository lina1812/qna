class User < ApplicationRecord
  has_many :author_questions, class_name: 'Question', inverse_of: :author, foreign_key: :author_id, dependent: :nullify
  has_many :author_answers, class_name: 'Answer', inverse_of: :author, foreign_key: :author_id, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
