module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable

    def score
      votes.sum(:value)
    end
  end
end
