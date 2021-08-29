require 'rails_helper'

feature 'User can show question', %q{
  In order to find the question wich I need
  As a guest or authenticated user
  I'd like to be able to look at the list questions
} do

  given!(:question) {create(:question)}
    scenario 'User views questions' do

      visit questions_path

      expect(page).to have_content 'Questions'
      expect(page).to have_content 'Question Title'
      expect(page).to have_content question.title
      expect(page).to have_link('Show', href: question_path(question.id))
      
    end

end