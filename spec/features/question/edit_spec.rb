require 'rails_helper'

feature 'User can edit his question', %q{
  In order to correct mistakes
  As an author of question
  I'd like ot be able to edit my question
} do

  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, author: user) }
  scenario 'Unauthenticated can not edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user', js: true do

    scenario 'edits his question' do
      sign_in user
      visit question_path(question)
      click_on 'Edit'
      within '.question' do
        fill_in 'Your question title', with: 'edited title'
        fill_in 'Your question body', with: 'edited body'
        click_on 'Save'

        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to have_content 'edited title'
        expect(page).to have_content 'edited body'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his answer with errors' do
      sign_in user
      visit question_path(question)
      click_on 'Edit'
      within '.question' do
        fill_in 'Your question body', with: ''
        click_on 'Save'
        expect(page).to have_content "Body can't be blank"
        expect(page).to have_content question.body
        expect(page).to have_selector 'textarea'
      end
    end
    
    scenario "tries to edit other user's question" do
      sign_in user2
      visit question_path(question)
      within '.question' do
       expect(page).to_not have_link 'Edit' 
      end
    end
    
  end
end
