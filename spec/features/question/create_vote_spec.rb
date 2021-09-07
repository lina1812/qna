require 'rails_helper'

feature 'User can add links to question', "
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, author: user2) }

  scenario 'User try to vote for not his question', js: true do
    sign_in(user)
    visit question_path(question)
    within '.question' do
      expect(page).to have_content 'Total vote: 0'
      click_on 'Vote for'
      expect(page).to have_content 'Total vote: 1'
      expect(page).to_not have_selector(:link_or_button, 'Vote for')
      expect(page).to have_content 'Delete your vote'
     end 
  end

  scenario 'User try to vote for his question', js: true do
    sign_in(user2)
    visit question_path(question)
    within '.question' do
      expect(page).to have_content 'Total vote: 0'
      expect(page).to_not have_selector(:link_or_button, 'Vote for')
      expect(page).to_not have_content 'Delete your vote'
     end 
  end
  
  scenario 'User delete his vote', js: true do
    sign_in(user)
    visit question_path(question)
    within '.question' do
      click_on 'Vote for'
      expect(page).to have_content 'Total vote: 1'
      click_on 'Delete your vote'
      expect(page).to have_content 'Total vote: 0'
      expect(page).to have_selector(:link_or_button, 'Vote for')
      expect(page).to_not have_selector(:link_or_button, 'Delete your vote')
     end 
  end

  scenario 'Unauthenticated can not vote', js: true do
    visit question_path(question)
    within '.question' do
      expect(page).to have_content 'Total vote: 0'
      expect(page).to_not have_selector(:link_or_button, 'Vote for')
      expect(page).to_not have_content 'Delete your vote'
     end
   end 
end
