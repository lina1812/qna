require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }
  let(:access_token) { create(:access_token) }

  let!(:questions) { create_list(:question, 2) }
  let!(:question) { questions.first }
  let(:question_with_author) { create(:question, author_id: access_token.resource_owner_id) }
  describe 'GET /api/v1/questions' do
    it_behaves_like 'API Index Object' do
      let(:api_path) { '/api/v1/questions' }
      let(:object_response) { json['questions'].first }
      let(:objects_response) { json['questions'] }
      let(:object) { question }
      let(:object_attributs) { %w[id title body created_at updated_at] }
      let(:size) { questions.size }
    end
  end

  describe 'GET /api/v1/questions/:id' do
    it_behaves_like 'API Show Object' do
      let(:api_path) { "/api/v1/questions/#{question.id}" }
      let(:object_response) { json['question'] }
      let(:object) { question }
      let(:object_attributs) { %w[id title body created_at updated_at] }
      let(:comments_content) { create(:comment, commentable: object) }
    end
  end

  describe 'POST /api/v1/questions' do
    it_behaves_like 'API Create Object' do
      let(:api_path) { '/api/v1/questions' }
      let(:new_object) { attributes_for(:question) }
      let(:object_response) { json['question'] }
      let(:params) { { question: new_object } }
      let(:attributs) { %w[title body] }
    end
  end

  describe 'PATCH /api/v1/questions/:id' do
    it_behaves_like 'API Update Object' do
      let(:api_path) { "/api/v1/questions/#{question_with_author.id}" }
      let(:object_response) { json['question'] }
      let(:old_object) { question_with_author }
      let(:new_object) { { title: 'NewTitle', body: 'NewBody' } }
      let(:new_attributs) { %w[title body] }
      let(:old_attributs) { %w[id created_at] }
      let(:params) { { question: new_object } }
    end
  end

  describe 'DELETE /api/v1/questions/:id' do
    it_behaves_like 'API Delete object' do
      let(:api_path) { "/api/v1/questions/#{question_with_author.id}" }
      let(:object_class) { question_with_author.class }
      let(:object) { question_with_author }
    end
  end
end
