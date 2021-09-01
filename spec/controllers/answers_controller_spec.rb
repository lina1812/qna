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
    
    context 'User can not edit not his answer' do
      before { login(user1) }
      it 'does not change answer' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'MyText'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, author: user) }
    let!(:answer) { create(:answer, author: user, question: question) }
    context 'Unauthenticated can not delete answer' do
      it 'does not delete answer' do
        expect { delete :destroy, params: { id: answer } , format: :js}.to_not change(Answer, :count)
      end
    end
    
    describe 'Authenticated user' do
      context 'Author delete his answer' do
        before {login(user)}
        it 'deletes the question' do
          expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
        end
      
        it 'renders destroy view' do
          delete :destroy, params: { id: answer }, format: :js 
          expect(response).to render_template :destroy
        end
      end
      context 'Other user delete answer' do 
        it 'does not delete the question' do
          login(user1)
          expect { delete :destroy, params: { id: answer }, format: :js}.to_not change(Answer, :count)
        end
      end
    end
  end
  
  describe 'POST #mark_as_best' do
    let!(:question) { create(:question, author: user) }
    let!(:answer) { create(:answer, author: user, question: question) }
    
    context 'Unauthenticated can not make answer the best' do
      it 'does not make best' do
        post :mark_as_best, params: { id: answer}, format: :js
        question.reload
        expect(question.best_answer).to eq nil
      end
    end
    
    describe 'Authenticated user' do
      context 'Author of question make answer the best' do
        before {login(user)}
        it 'creates an association with the best answer to the question' do
          post :mark_as_best, params: { id: answer}, format: :js
          question.reload
          expect(question.best_answer).to eq answer
        end
        
        it 'makes another answer the best' do
          post :mark_as_best, params: { id: answer1}, format: :js
          expect(question.reload.best_answer).to eq answer1
          post :mark_as_best, params: { id: answer}, format: :js
          question.reload
          expect(question.best_answer).to eq answer
        end
      end
      context 'Other user try to make answer the best' do 
        it 'does not make the best' do
          post :mark_as_best, params: { id: answer}, format: :js
          question.reload
          expect(question.best_answer).to eq nil
        end
      end
    end
  end
end
