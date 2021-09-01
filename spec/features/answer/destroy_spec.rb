require 'rails_helper'

feature 'Author can destroy his answer', "
  An authenticated user
  I'd like to be able to destroy my answer
" do
  given(:users) { create_list(:user, 2) }
  given(:question) { create(:question, author: users[0]) }
  given!(:answer) {create(:answer, question: question, author: users[0], body: 'Text_answer_1')}

  scenario 'Unauthenticated can not delete answer', js: true do
    visit question_path(question)
    expect(page).to_not have_link 'Delete Answer'
  end
  
  describe 'Authenticated user', js: true do
    
    scenario 'Author try delete his answer' do
      sign_in(users[0])
      visit question_path(question)
      click_on 'Delete Answer'
      
      expect(page).to_not have_content answer.body
    end

    scenario "User try to delete someone else's answer" do
      sign_in(users[1])
      visit question_path(question)
      expect(page).to_not have_content 'Delete Answer'
    end
  end



end
