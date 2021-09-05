require 'rails_helper'

feature 'User can add links to question', "
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
" do
  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, :with_links, author: user, question: question) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete link'
  end

  describe 'Authenticated user', js: true do
    scenario 'delete link from his answer' do
      sign_in user
      visit question_path(question)
      within '.answers' do
        expect(page).to have_link 'Google'
        click_on 'Delete link'
        expect(page).to_not have_link 'Google'
      end
    end

    scenario "tries to edit other user's answer" do
      sign_in user2
      visit question_path(question)
      within '.answers' do
        expect(page).to_not have_link 'Delete link'
      end
    end
  end
end
