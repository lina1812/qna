require 'rails_helper'

describe 'Answers API', type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }
  let(:access_token) { create(:access_token) }
  let!(:question) { create(:question) }
  let!(:answers) { create_list(:answer, 3, question: question) }
  let(:answer) { answers.first }
  let(:answer_with_author) { create(:answer, question: question, author_id: access_token.resource_owner_id) }

  describe 'GET /api/v1/questions/:question_id/answers' do
    it_behaves_like 'API Index Object' do
      let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
      let(:object_response) { json['answers'].first }
      let(:objects_response) { json['answers'] }
      let(:object) { answer }
      let(:object_attributs) { %w[id body created_at updated_at] }
      let(:size) { answers.size }
    end
  end

  describe 'GET /api/v1/questions/:question_id/answers/:id' do
    it_behaves_like 'API Show Object' do
      let(:api_path) { "/api/v1/questions/#{question.id}/answers/#{answer.id}" }
      let(:object_response) { json['answer'] }
      let(:object) { answer }
      let(:object_attributs) { %w[id body created_at updated_at] }
    end
  end

  describe 'POST /api/v1/questions/:question_id/answers' do
    it_behaves_like 'API Create Object' do
      let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
      let(:new_object) { attributes_for(:answer) }
      let(:object_response) { json['answer'] }
      let(:params) { { answer: new_object } }
      let(:attributs) { %w[body] }
    end
  end

  describe 'PATCH /api/v1/questions/:question_id/answers/:id' do
    it_behaves_like 'API Update Object' do
      let(:api_path) { "/api/v1/questions/#{question.id}/answers/#{answer_with_author.id}" }
      let(:object_response) { json['answer'] }
      let(:old_object) { answer_with_author }
      let(:new_object) { { body: 'NewBody' } }
      let(:new_attributs) { %w[body] }
      let(:old_attributs) { %w[id created_at] }
      let(:params) { { answer: new_object } }
    end
  end

  describe 'DELETE /api/v1/questions/:question_id/answers/:id' do
    it_behaves_like 'API Delete object' do
      let(:api_path) { "/api/v1/questions/#{question.id}/answers/#{answer_with_author.id}" }
      let(:object_class) { answer_with_author.class }
      let(:object) { answer_with_author }
    end
  end
end
