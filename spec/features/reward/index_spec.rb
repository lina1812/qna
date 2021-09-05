require 'rails_helper'

feature 'User can show revards', "
  As authenticated user
  I'd like to be able to view my rewards for best answers
"  do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }
  given!(:reward) { create(:reward, question: question ) }

  scenario 'User views his rewards', js: true do
    sign_in user
    
    visit question_path(question)
    click_on('Make the Best')
    
    visit rewards_path
    
    expect(page).to have_content 'Question title'
    expect(page).to have_content question.title
    expect(page).to have_content 'Reward name'
    expect(page).to have_content reward.name
    expect(page).to have_content 'Reward image'
    expect(page).to have_css("img[src*='132984.jpg']")
  end
end