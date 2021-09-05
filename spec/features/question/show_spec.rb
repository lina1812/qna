require 'rails_helper'

feature 'User can show question', "
  In order to find the answer wich I need
  As a guest or authenticated user
  I'd like to be able to look at the question and answers for them
" do
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  given!(:link) { create(:link, linkable: question, name: 'MyGist', url: 'https://gist.github.com/lina1812/fc97fe4f6b0365b3c5a78ffee970c84f') }
  given!(:reward) { create(:reward, question: question) }

  scenario 'User views question' do
    visit question_path(question.id)

    expect(page).to have_content 'Question Title'
    expect(page).to have_content question.title
    expect(page).to have_content 'Question Body'
    expect(page).to have_content question.body
    expect(page).to have_content question.answers.first.body
    expect(page).to have_content 'My Text'
    expect(page).to have_content 'MyReward'
    expect(page).to have_css("img[src*='132984.jpg']")
  end
end
