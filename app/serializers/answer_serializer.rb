class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at
  has_many :files, serializer: FileSerializer
  has_many :links
  has_many :comments
  belongs_to :author
end
