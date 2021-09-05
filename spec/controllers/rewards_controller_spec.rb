require 'rails_helper'

RSpec.describe RewardsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author: user, best_answer: answer) }
  let(:answer)  { create(:question, author: user) }
  let(:reward) { create(:question) }
  describe 'GET #index' do
    before do
      login(user) 
      get :index 
    end
    it 'populates an array of all users rewards' do
      expect(assigns(:rewards)).to match_array(user.rewards)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

 
end
