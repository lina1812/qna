shared_examples_for 'API Delete object' do
  it_behaves_like 'API Authorizable' do
    let(:method) { :delete }
  end
  context 'authorized' do
    before { delete api_path, params: { access_token: access_token.token }, headers: headers }

    it_behaves_like 'API Successful'

    it 'should not find objest' do
      expect(object_class.where(id: object.id).first).to be_nil
    end
  end
end
