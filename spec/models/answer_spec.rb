require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should validate_presence_of :body }
  it_behaves_like 'API Model Validation' do
    let(:klass) { Answer }
  end
end
