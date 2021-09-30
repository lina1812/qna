require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { create(:user) }
  let(:user1) { create(:user, email: 'email2@example.com') }
  let!(:question) { create(:question, author: user) }

  describe 'POST #create' do
    context 'Unauthenticated can not subscrib question' do
      it 'does not subscrib' do
        expect { post :create, params: { question_id: question.id } }.to_not change(question.subscriptions, :count)
      end
    end

    describe 'Authenticated user' do
      it 'User subscrib to question' do
        login(user1)
        expect { post :create, params: { question_id: question.id, user_id: user1.id } }.to change(UserSubscription, :count).by(1)
      end
    end
  end
end
