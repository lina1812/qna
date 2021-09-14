class Vote < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :author_votes
  belongs_to :votable, polymorphic: true

  validates :value, presence: true, inclusion: { in: [1, -1] }
  validates_uniqueness_of :author_id, scope: %i[votable_type votable_id]
end
