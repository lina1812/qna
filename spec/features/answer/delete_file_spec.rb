require 'rails_helper'

feature 'User can delete attached files', "
  In order to correct mistakes
  As an author of answer
  I'd like ot be able to delete attached files
" do
  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, :with_files, question: question, author: user) }

  scenario 'Unauthenticated can not delete files' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete file'
  end

  describe 'Authenticated user', js: true do
    scenario 'delet attached file in his answer' do
      sign_in user
      visit question_path(question)
      within '.answers' do
        expect(page).to have_link 'rails_helper.rb'
        click_on 'Delete file'
        expect(page).to_not have_link 'rails_helper.rb'
      end
    end

    scenario "tries to edit other user's question" do
      sign_in user2
      visit question_path(question)
      within '.answers' do
        expect(page).to_not have_link 'Delete file'
      end
    end
  end
end
