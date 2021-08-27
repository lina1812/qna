require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let (:question) { create(:question) } 
  let (:answer) { create(:answer) }
  
  describe 'GET #index' do
    let (:answers) { create_list(:answer,3) }
    before { get :index, params: { question_id: question.id } }
    it 'populates an array of all answer' do
      expect(assigns(:answers)).to match_array(answer)
    end
      
    it 'renders index view' do
      expect(response).to render_template :index      
    end
    
  end

  describe 'GET #show' do

    before { get :show, params: { id: answer } }

    it 'renders show view' do
      expect(response).to render_template :show      
    end
    
  end
  
  describe 'GET #new' do
    
    before { get :new , params: { question_id: question.id } }
    
    it 'renders new view' do
      expect(response).to render_template :new      
    end
    
  end

  describe 'GET #edit' do  
    before { get :edit, params: { id: answer } }

    it 'renders edit view' do
      expect(response).to render_template :edit      
    end  
  end
    
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question.id } }.to change(question.answers, :count).by(1)
      end
      
      it 'redirects to show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question.id } 
        expect(response).to redirect_to assigns(:answer)     
      end
    end
    
    context 'with invalid attributes' do
      it 'does not saves the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id } }.not_to change(Answer, :count)
        
      end
      
      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id }
        expect(response).to render_template :new  
      end
      
    end
  end
  
 
  describe 'PATCH #update' do  
    context 'with valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, params: {id: answer, answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq answer
      end
      
      
      it 'change answer atributes' do
        patch :update, params: {id: answer, answer: {body: 'new body'} }
        answer.reload
        expect(answer.body).to eq 'new body' 
      end
      
      it 'redirects updated answer' do
        patch :update, params: {id: answer, answer: attributes_for(:answer) }
        expect(response).to redirect_to answer    
      end
    end
    
    context 'with invalid attributes' do
      before { patch :update, params: {id: answer, answer: attributes_for(:answer, :invalid) } }
      it 'does not change answer' do
        answer.reload
        expect(answer.body).to eq 'MyText' 
      end
      it 're-renders edit view' do
        expect(response).to render_template :edit  
      end
      
    end
  end
end
