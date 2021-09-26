shared_examples_for 'API Model Validation' do
  it { should have_many(:links).dependent(:destroy) }
  it 'have many attached files' do
    expect(klass.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
end
