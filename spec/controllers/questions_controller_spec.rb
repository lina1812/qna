require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:user1) { create(:user, email: 'email2@example.com') }
  let(:question) { create(:question, author: user) }
  let(:question1) { create(:question, author: user1) }
  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }
    before { get :index }
    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    render_views
    before { get :show, params: { id: question } }

    it 'renders show view' do
      expect(response).to render_template :show
      expect(response).to render_template(partial: '_question')
      expect(response).to render_template(partial: '_all_answers')
    end
  end

  describe 'GET #new' do
    before { login(user) }

    before { get :new }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'saves a new question in the database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not saves the question' do
        expect { post :create, params: { question: attributes_for(:question, :invalid) } }.not_to change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    let!(:question) { create(:question, author: user) } 
    describe 'Authenticated user' do
      before { login(user) }
      context 'with valid attributes' do
        it 'assigns the requested question to @question' do
          patch :update, params: { id: question, question: attributes_for(:question), format: :js }
          expect(assigns(:question)).to eq question
        end
      
        it 'change question atributes' do
          patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, format: :js }
          question.reload
          expect(question.title).to eq 'new title'
          expect(question.body).to eq 'new body'
        end
        
        it 'renders update view' do
          patch :update, params: {id: question, question: { title: 'new title', body: 'new body' }, format: :js }
          expect(response).to render_template :update
        end
      end
      
      context 'with invalid attributes' do
        before { patch :update, params: { id: question, question: attributes_for(:question, :invalid) }, format: :js }
        it 'does not change question' do
          question.reload
          expect(question.title).to eq 'MyString'
          expect(question.body).to eq 'MyText'
        end
        it 'renders update view' do
          expect(response).to render_template :update
        end
      end
    end
    context 'Unauthenticated can not edit question' do
      it 'does not change question' do
        patch :update, params: {id: question, question: { title: 'new title', body: 'new body' }, format: :js }
        question.reload
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }
    let!(:question) { create(:question, author: user) }
    context 'Author delete his question' do
      it 'deletes the question' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    let!(:question1) { create(:question, author: user1) }
    context 'Other user delete question' do
      it 'does not delete the question' do
        expect { delete :destroy, params: { id: question1 } }.to_not change(Question, :count)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: question1 }
        expect(response).to redirect_to question_path(question1)
      end
    end
  end
end
