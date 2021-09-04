class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, url: true
  
  def is_a_gist?
    url.start_with?('https://gist.github.com/')
  end
  
  def gist_id
    url.split('?').first.split('/').last
  end
  
  def raw_gist
    client = Octokit::Client.new
    response = client.gist(gist_id)
    response[:files].to_hash.values.first[:content]
  end
end
