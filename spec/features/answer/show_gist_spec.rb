require 'rails_helper'

feature 'User can view text of the Gist',
        "
   In order to find the answer wich I need
   As a guest or authenticated user
   I'd like to be able to view link like a gist when I look at the answer
   " do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }
  given!(:link) { create(:link, linkable: answer, name: 'MyGist', url: 'https://gist.github.com/lina1812/fc97fe4f6b0365b3c5a78ffee970c84f') }

  scenario 'User can view text of the Gist', js: true do
    visit question_path(question)
    within '.answers' do
      expect(page).to have_content text
    end
  end
end
