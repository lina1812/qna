require 'rails_helper'

feature 'User can create answer', "
  In order to give answer to the question
  As an authenticated user
  I'd like to be able to give the answer
  When I viewing the question
" do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question.id)
    end

    scenario 'give answer' do
      fill_in 'answer_body', with: 'text text text'
      click_on 'Publish'

      expect(page).to have_content question.title
      expect(page).to have_content question.body
      expect(page).to have_current_path(question_path(question.id))
      expect(page).to have_content 'text text text'
    end

    scenario 'give answer with errors' do
      click_on 'Publish'
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to give a answer', js: true do
    visit question_path(question.id)
    expect(page).to_not have_content 'Publish'
  end
end
