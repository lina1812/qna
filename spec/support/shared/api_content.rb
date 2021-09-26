shared_examples_for 'API Content' do
  it 'returns list of content' do
    expect(object_response[content_name].size).to eq size
  end

  it 'contains author object' do
    expect(author_response).to eq author.id
  end

  it_behaves_like 'API Check Fields' do
    let(:attributs) { content_attributs }
    let(:content_object_response) { content_response }
    let(:content_object) { content }
  end
end
