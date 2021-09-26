class FileSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :filename, :file_url

  def file_url
    rails_blob_path(object, only_path: true)
  end
end
