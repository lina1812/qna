require 'rails_helper'

feature 'Author can destroy his answer', "
  An authenticated user
  I'd like to be able to destroy my answer
" do
  given(:users) { create_list(:user, 2) }
  given(:question) { create(:question, author: users[0]) }
  background do
    sign_in(users[0])
  end
  describe 'Authenticated user' do
    scenario 'Author try his answer' do
      answer = create(:answer, question: question, author: users[0], body: 'Text_answer_1')
      visit question_path(id: question.id)
      click_on 'Delete Answer'

      expect(page).to have_content 'Your answer was successfully deleted.'
      expect(page).to_not have_content answer.body
    end

    scenario "User is trying to delete someone else's answer" do
      create(:answer, question: question, author: users[1])
      visit question_path(id: question.id)

      expect(page).to_not have_content 'Delete Answer'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'Guest is trying to delete an answer' do
      create(:answer, question: question, author: users[1])
      visit question_path(id: question.id)

      expect(page).to_not have_content 'Delete Answer'
    end
  end
end
