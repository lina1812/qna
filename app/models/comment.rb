class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :author_votes
  belongs_to :commentable, polymorphic: true, touch: true

  validates :body, presence: true
end
