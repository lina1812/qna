require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  let(:user) { create(:user) }

  let(:question) { create(:question, author: user) }
  let(:question1) { create(:question) }
  let(:answer) { create(:answer, author: user) }
  let(:answer1) { create(:answer) }
  let(:vote) { create(:vote, author: user) }
  let(:vote1) { create(:vote) }

  describe '#author_of?' do
    context 'with valid attributes' do
      it 'verifies that the current user is the author of the question' do
        expect(user).to be_author_of(question)
      end
      it 'verifies that the current user is the author of the answer' do
        expect(user).to be_author_of(answer)
      end
      it 'verifies that the current user is the author of the vote' do
        expect(user).to be_author_of(vote)
      end
    end
    context 'with valid attributes' do
      it 'verifies that the current user is not author of the question' do
        expect(user).to_not be_author_of(question1)
      end
      it 'verifies that the current user is not author of the answer' do
        expect(user).to_not be_author_of(answer1)
      end
      it 'verifies that the current user is not author of the vote' do
        expect(user).to_not be_author_of(vote1)
      end
    end
  end
  
  describe '.find_for_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
    let(:service) { double('FindForOauth') }

    it 'calls FindForOauth' do
      expect(FindForOauth).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end
  end
end
