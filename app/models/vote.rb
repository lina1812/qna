class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true
  
  validates :value, presence: true
  validates_uniqueness_of :user_id, scope: [:votable_type, :votable_id]
end
