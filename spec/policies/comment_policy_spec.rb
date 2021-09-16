require 'rails_helper'

RSpec.describe CommentPolicy do
  let(:user) { create(:user) }
  let(:guest) { nil }
  subject { described_class }

  permissions :create? do
    it 'grant access if it is authenticated user' do
      expect(subject).to permit(user)
    end

    it 'denies access if user is a guest ' do
      expect(subject).not_to permit(guest)
    end
  end
end
