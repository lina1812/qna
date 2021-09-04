require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to :linkable }

  it { should validate_presence_of :name }
  it { should validate_presence_of :url }
  it { is_expected.to validate_url_of(:url) }
  
  let(:question) { create(:question) }
  let(:gist) { create(:link, linkable: question, name: 'MyGist', url: 'https://gist.github.com/lina1812/fc97fe4f6b0365b3c5a78ffee970c84f' ) }
  let(:google) { create(:link, linkable: question ) }
  describe 'is_a_gist?' do
    it 'should be true with gist url' do
      expect(gist.is_a_gist?).to eq true
    end
    it 'should be false with another url' do
      expect(google.is_a_gist?).to eq false
    end
  end
  describe 'is_a_gist?' do
    it 'should be true with gist url' do
      expect(gist.is_a_gist?).to eq true
    end
    it 'should be false with another url' do
      expect(google.is_a_gist?).to eq false
    end
  end
  
  describe 'gist_id' do
    it 'should return gist id' do
      expect(gist.gist_id).to eq 'fc97fe4f6b0365b3c5a78ffee970c84f'
    end
  end
  
  describe 'raw_gist' do
    it 'should return gist id' do
      expect(gist.raw_gist).to eq 'My Text'
    end
  end
  
end
