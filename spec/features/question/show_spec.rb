require 'rails_helper'

feature 'User can show question', "
  In order to find the answer wich I need
  As a guest or authenticated user
  I'd like to be able to look at the question and answers for them
" do
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'User views question' do
    visit question_path(question.id)

    expect(page).to have_content 'Question Title'
    expect(page).to have_content question.title
    expect(page).to have_content 'Question Body'
    expect(page).to have_content question.body

    expect(page).to have_content question.answers.first.body
  end
end
