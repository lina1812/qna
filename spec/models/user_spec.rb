require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  
  let(:user) { create(:user) }

  let(:question) { create(:question, author: user) }
  let(:question1) { create(:question) }
  let(:answer) { create(:answer, author: user) }
  let(:answer1) { create(:answer) }
  
  describe '#author_of' do
    context 'with valid attributes' do
      it 'verifies that the current user is the author of the question' do      
        expect(user.author_of(question)).to eq true
      end
      it 'verifies that the current user is the author of the answer' do      
        expect(user.author_of(answer)).to eq true
      end
    end
    context 'with valid attributes' do 
      it 'verifies that the current user is not author of the question' do
        expect(user.author_of(question1)).to eq false
      end
      it 'verifies that the current user is not author of the answer' do
        expect(user.author_of(answer1)).to eq false
      end
    end
  end
end
