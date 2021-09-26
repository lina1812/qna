shared_examples_for 'API Index Object' do
  it_behaves_like 'API Authorizable' do
    let(:method) { :get }
  end
  context 'authorized' do
    before { get api_path, params: { access_token: access_token.token }, headers: headers }

    it_behaves_like 'API Successful'

    it_behaves_like 'API Check Fields' do
      let(:attributs) { object_attributs }
      let(:content_object_response) { object_response }
      let(:content_object) { object }
    end

    it 'returns list of answers' do
      expect(objects_response.size).to eq size
    end

    it 'contains user object' do
      expect(object_response['author']['id']).to eq object.author.id
    end
  end
end
