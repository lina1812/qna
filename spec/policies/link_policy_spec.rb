require 'rails_helper'

RSpec.describe LinkPolicy do
  let(:user) { create(:user) }
  let(:guest) { nil }
  let!(:question) { create(:question, :with_links, author: user) }
  subject { described_class }

  permissions :destroy? do
    it 'grant access if user is author' do
      expect(subject).to permit(user, question.links.first)
    end

    it 'denies access if user is not author' do
      expect(subject).not_to permit(User.new, question.links.first)
    end
  end
end
