class User < ApplicationRecord
  has_many :author_tests, class_name: 'Test', inverse_of: :author, foreign_key: :author_id, dependent: :nullify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
