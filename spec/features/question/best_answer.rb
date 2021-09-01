require 'rails_helper'

feature 'User can make answer the Best', %q{
  In order to mark the Best answer
  As an author of question
  I'd like to be able to make one answer as the Best
} do

  given(:users) { create_list(:user, 2) }
  given(:question) { create(:question, author: users[0]) }
  given!(:answer) {create(:answer, question: question, body: 'FirstAnswer' )}
  given!(:answer1) {create(:answer, question: question )}
  scenario 'Unauthenticated can not make answer the best' do
    visit question_path(question)
    expect(page).to_not have_link 'Make the Best'
  end

  describe 'Authenticated user', js: true do
    describe 'edits his question' do
      background do
        sign_in users[0]
        visit question_path(question)
        first('.make_best').click_on('Make the Best')
      end
      
      scenario 'mark the best answer' do
        within '.best_answer' do
          expect(page).to have_content 'The Best answer'
          expect(page).to_not have_link 'Make the Best'
          expect(page).to have_content 'FirstAnswer' 
        end
        within '.other-answers' do
          expect(page).to have_content 'MyText' 
          expect(page).to have_link 'Make the Best'
          expect(page).to_not have_content 'FirstAnswer'
          
        end
        expect(page.body).to match(/.*FirstAnswer.*MyText/)
      end
      
      scenario 'change the best answer' do
        click_on('Make the Best')
        within '.best_answer' do
          expect(page).to have_content 'The Best answer'
          expect(page).to_not have_link 'Make the Best'
          expect(page).to have_content 'MyText' 
        end
        within '.other-answers' do
          expect(page).to_not have_content 'MyText' 
          expect(page).to have_link 'Make the Best'
          expect(page).to have_content 'FirstAnswer'
          
        end
        expect(page.body).to match(/.*MyText.*FirstAnswer/)
      end
    end
    
    scenario 'try to edit not his question' do
      sign_in users[1]
      visit question_path(question)
      expect(page).to_not have_link 'Make the Best'
    end    
  end
end
