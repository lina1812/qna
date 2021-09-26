shared_examples_for 'API Check Fields' do
  it 'returns all public fields' do
    local = content_object
    local = OpenStruct.new(local) if local.is_a?(Hash)

    attributs.each do |attr|
      expect(content_object_response[attr]).to eq local.send(attr).as_json
    end
  end
end
