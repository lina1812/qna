require 'rails_helper'

feature 'Author can destroy his question', "
  An authenticated user
  I'd like to be able to destroy his question
" do
  given(:users) { create_list(:user, 2) }
  given(:question_user1) { create(:question, author: users[0]) }
  given(:question_user2) { create(:question, author: users[1]) }

  describe 'Authenticated user' do
    background do
      sign_in(users[0])
    end

    scenario 'User try his question' do
      visit question_path(id: question_user1.id)
      click_on 'Delete'

      expect(page).to have_content 'Your question was successfully deleted.'
      expect(page).to_not have_content question_user1.title
    end

    scenario "User is trying to delete someone else's question" do
      visit question_path(id: question_user2.id)
      expect(page).to_not have_content 'Delete'
    end
  end
  describe 'Unauthenticated user' do
    scenario 'Guest is trying to delete a question' do
      visit question_path(id: question_user2.id)
      expect(page).to_not have_content 'Delete'
    end
  end
end
