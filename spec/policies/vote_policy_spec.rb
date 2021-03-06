require 'rails_helper'

RSpec.describe VotePolicy do
  let(:user) { create(:user) }

  subject { described_class }

  permissions :destroy? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:vote))
    end

    it 'grant access if user is author' do
      expect(subject).to permit(user, create(:vote, author: user))
    end

    it 'denies access if user is not author' do
      expect(subject).not_to permit(User.new, create(:vote, author: user))
    end
  end
end
