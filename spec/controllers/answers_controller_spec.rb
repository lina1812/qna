require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:user1) { create(:user, email: 'user1@example.com') }
  let(:question) { create(:question, author: user) }
  let(:answer) { create(:answer, author: user, question: question) }
  let(:answer1) { create(:answer, author: user1, question: question) }

  describe 'POST #create' do
    before { login(user) }
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question.id }, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'renders create view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question.id }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not saves the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id }, format: :js }.not_to change(Answer, :count)
      end

      it 'renders create view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id }, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    let!(:answer) { create(:answer, author: user, question: question) }
    describe 'Authenticated user' do
      before { login(user) }
      
      context 'with valid attributes' do
        it 'assigns the requested answer to @answer' do
          patch :update, params: { id: answer, answer: attributes_for(:answer) }, format: :js
          expect(assigns(:answer)).to eq answer
        end
      
        it 'change answer atributes' do
          patch :update, params: { id: answer, answer: { body: 'new body' }, format: :js }
          answer.reload
          expect(answer.body).to eq 'new body'
        end
      
        it 'renders update view' do
          patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
          expect(response).to render_template :update
        end
      end
      
      context 'with invalid attributes' do
        before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js }
        it 'does not change answer' do
          answer.reload
          expect(answer.body).to eq 'MyText'
        end
        it 'renders update view' do
          expect(response).to render_template :update
        end
      end
    end
    
    context 'Unauthenticated can not edit answer' do
      it 'does not change answer' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'MyText'
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }
    let!(:question) { create(:question, author: user) }
    let!(:answer) { create(:answer, author: user, question: question) }
    context 'Author delete his answer' do
      it 'deletes the question' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirects to question_path' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end
    let!(:answer1) { create(:answer, author: user1, question: question) }
    context 'Other user delete answer' do
      it 'does not delete the question' do
        expect { delete :destroy, params: { id: answer1 } }.to_not change(Answer, :count)
      end
    end
  end
end
