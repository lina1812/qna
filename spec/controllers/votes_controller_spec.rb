require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:question) { create(:question, author: user2) }
 
  describe 'POST #create' do

    context 'Unauthenticated can not vote' do
      it 'does not create vote' do
        expect { post :create, params: { vote: attributes_for(:vote, votable_type: question.class.name, votable_id: question.id ) }, format: :js }.to_not change(Vote, :count)
      end
    end
    
    context 'User vote for not his question' do
      before { login(user) }
      it 'saves a new vote in the database' do
        login(user)
        expect { post :create, params: { vote: attributes_for(:vote , votable_type: question.class.name, votable_id: question.id)  }, format: :js }.to change(Vote, :count).by(1)
      end
    end

    context 'User try to vote for his question' do
      before { login(user2) }
      it 'does not create vote' do
        expect { post :create, params: { vote: attributes_for(:vote, votable_type: question.class.name, votable_id: question.id ) }, format: :js }.to_not change(Vote, :count)
      end
    end
  end
  
  
  describe 'DELETE #destroy' do
    let!(:vote) { create(:vote, votable: question, user: user) }
    context 'Unauthenticated can not delete link' do
      it 'does not delete answer' do
        expect { delete :destroy, params: { id: vote }, format: :js }.to_not change(Vote, :count)
      end
    end
    context 'User delete his vote' do
      before { login(user) }
      it 'deletes the vote' do
        expect { delete :destroy, params: { id: vote }, format: :js }.to change(Vote, :count).by(-1)
      end
    end
    context 'User try to delete not his vote' do
      before { login(user2) }
      it 'does not delete the vote' do
        expect { delete :destroy, params: { id: vote }, format: :js }.to_not change(Vote, :count)
      end
    end
  end
end
