require 'rails_helper'

feature 'Author can destroy his answer', "
  An authenticated user
  I'd like to be able to destroy my answer
" do
  given(:users) { create_list(:user, 2) }
  given(:question) { create(:question, author_id: users[0].id) }
  given(:answer1) { create(:answer, question_id: question.id, author_id: users[0].id, body: 'Text_answer_1') }
  given(:answer2) { create(:answer, question_id: question.id, author_id: users[1].id, body: 'Text_answer_2') }

  background do
    sign_in(users[0])
  end
  scenario 'Author try his answer' do
    answer1
    visit question_path(id: question.id)
    click_on 'Delete Answer'

    expect(page).to have_content 'Your answer was successfully deleted.'
    expect(page).to_not have_content answer2.body
  end

  scenario "User is trying to delete someone else's answer" do
    answer2
    visit question_path(id: question.id)

    expect(page).to_not have_content 'Delete Answer'
  end
end
