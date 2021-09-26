require 'rails_helper'

RSpec.describe FilePolicy do
  let(:user) { create(:user) }
  let(:guest) { nil }
  let!(:question) { create(:question, :with_files, author: user) }
  subject { described_class }

  permissions :destroy? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), question.files.first)
    end

    it 'grant access if user is author' do
      expect(subject).to permit(user, question.files.first)
    end

    it 'denies access if user is not author' do
      expect(subject).not_to permit(User.new, question.files.first)
    end
  end
end
