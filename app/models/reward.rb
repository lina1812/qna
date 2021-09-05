class Reward < ApplicationRecord
  belongs_to :question

  has_one_attached :image

  validates :name, presence: true
end
