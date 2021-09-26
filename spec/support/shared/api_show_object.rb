shared_examples_for 'API Show Object' do
  it_behaves_like 'API Authorizable' do
    let(:method) { :get }
  end
  context 'authorized' do
    let!(:comments) { create_list(:comment, 3, commentable: object) }
    let!(:file) do
      object.files.attach(
        io: File.open("#{Rails.root}/spec/rails_helper.rb"),
        filename: 'rails_helper.rb'
      )
    end
    let!(:link) { create(:link, linkable: object) }
    before { get api_path, params: { access_token: access_token.token }, headers: headers }

    it_behaves_like 'API Successful' do
      let(:content_response) { object_response }
      let(:content) { object }
    end

    it_behaves_like 'API Check Fields' do
      let(:attributs) { object_attributs }
      let(:content_object_response) { object_response }
      let(:content_object) { object }
    end

    it 'contains user object' do
      expect(object_response['author']['id']).to eq object.author.id
    end
    describe 'comments' do
      it_behaves_like 'API Content' do
        let(:content_name) { 'comments' }
        let(:content) { comments.first }
        let(:content_response) { object_response['comments'].first }
        let(:author_response) { content_response['author']['id'] }
        let(:author) { content.author }
        let(:size) { object.comments.size }
        let(:content_attributs) { %w[id body created_at updated_at] }
      end
    end

    describe 'files' do
      it_behaves_like 'API Content' do
        let(:content_name) { 'files' }
        let(:content) { object.files.first }
        let(:author_response) { object_response['author']['id'] }
        let(:author) { object.author }
        let(:content_response) { object_response['files'].first }
        let(:size) { object.files.size }
        let(:content_attributs) { %w[id filename] }
      end
    end
    describe 'links' do
      it_behaves_like 'API Content' do
        let(:content_name) { 'links' }
        let(:content) { link }
        let(:author_response) { object_response['author']['id'] }
        let(:author) { object.author }
        let(:content_response) { object_response['links'].first }
        let(:size) { object.links.size }
        let(:content_attributs) { %w[id name url] }
      end
    end
  end
end
