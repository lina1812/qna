require 'rails_helper'

RSpec.describe QuestionPolicy do
  let(:user) { create(:user) }
  let(:guest) { nil }
  subject { described_class }

  permissions :index? do
    it 'denies access if user is a guest ' do
      expect(subject).to permit(guest)
    end
  end

  permissions :show? do
    it 'denies access if user is a guest ' do
      expect(subject).to permit(guest)
    end
  end

  permissions :create? do
    it 'grant access if it is authenticated user' do
      expect(subject).to permit(user)
    end

    it 'denies access if user is a guest ' do
      expect(subject).not_to permit(guest)
    end
  end

  permissions :update? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:question))
    end

    it 'grant access if user is author' do
      expect(subject).to permit(user, create(:question, author: user))
    end

    it 'denies access if user is not author' do
      expect(subject).not_to permit(User.new, create(:question, author: user))
    end
  end

  permissions :destroy? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:question))
    end

    it 'grant access if user is author' do
      expect(subject).to permit(user, create(:question, author: user))
    end

    it 'denies access if user is not author' do
      expect(subject).not_to permit(User.new, create(:question, author: user))
    end
  end

  permissions :vote? do
    it 'grants access if user is admin' do
      expect(subject).to permit(User.new(admin: true), create(:question))
    end

    it 'grant access if user is author of question' do
      expect(subject).to permit(user, create(:question))
    end

    it 'denies access if user is not author of question' do
      expect(subject).not_to permit(user, create(:question, author: user))
    end
  end
end
