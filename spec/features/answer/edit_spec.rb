require 'rails_helper'

feature 'User can edit his answer', "
  In order to correct mistakes
  As an author of answer
  I'd like ot be able to edit my answer
" do
  given!(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user', js: true do
    describe 'edits his answer' do
      background do
        sign_in user
        visit question_path(question)
        click_on 'Edit'
      end

      scenario 'with correct parameters' do
        within '.answers' do
          fill_in 'Your answer', with: 'edited answer'
          click_on 'Save'
          expect(page).to_not have_content answer.body
          expect(page).to have_content 'edited answer'
          expect(page).to_not have_selector 'textarea'
        end
      end

      scenario 'with errors' do
        within '.answers' do
          fill_in 'Your answer', with: ''
          click_on 'Save'
          expect(page).to have_content "Body can't be blank"
          expect(page).to have_content answer.body
          expect(page).to have_selector 'textarea'
        end
      end
      scenario 'with attached file' do
        within '.answers' do
          fill_in 'Your answer', with: 'edited answer'
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
          click_on 'Save'
          expect(page).to have_link 'rails_helper.rb'
          expect(page).to have_link 'spec_helper.rb'
        end
      end
      scenario 'with link' do
        within '.answers' do
          fill_in 'Your answer', with: 'edited answer'
          click_on 'add link'
          fill_in 'Name', with: 'Google'
          fill_in 'Url', with: 'https://google.com'
          click_on 'Save'
          expect(page).to have_link 'Google', href: 'https://google.com'
        end
      end
    end
  end

  scenario "tries to edit other user's question" do
    sign_in user2
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'Edit'
    end
  end
end
