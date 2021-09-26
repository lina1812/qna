class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :short_title
  has_many :files, serializer: FileSerializer
  has_many :links
  has_many :answers
  has_many :comments
  belongs_to :author

  def short_title
    object.title.truncate(7)
  end
end
