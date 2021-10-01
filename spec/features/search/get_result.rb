require 'sphinx_helper'

feature 'User can search for answer', "
  In order to find needed answer
  As a User
  I'd like to be able to search for the answer
" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) } 
  given!(:answer) { create(:answer, question: question, author: user) } 
  given!(:comment) { create(:comment, commentable: question, author: user) } 
  scenario 'User searches for the answer', sphinx: true do
    visit new_search_path
    select 'Answers', from: 'Select'
    fill_in 'search', with: 'MyText'
    ThinkingSphinx::Test.run do
      click_on 'Search'
      expect(page).to have_content 'MyText'
    end   
  end
  
  scenario 'User searches for the question', sphinx: true, js:true do
    visit new_search_path
    ThinkingSphinx::Test.run do
      select 'Question', from: 'Select'
      fill_in 'search', with: 'MyString'
      click_on 'Search'
      expect(page).to have_content 'MyString'
    end   
  end
  
  scenario 'User searches for the comment', sphinx: true, js:true do
    visit new_search_path
    ThinkingSphinx::Test.run do
      select 'Comments', from: 'Select'
      fill_in 'search', with: 'MyText'
      click_on 'Search'
      expect(page).to have_content 'MyText'
    end
  end
  
  scenario 'User searches for the user', sphinx: true, js:true do
    visit new_search_path
    ThinkingSphinx::Test.run do
      select 'Users', from: 'Select'
      fill_in 'search', with: 'user4'
      click_on 'Search'
      expect(page).to have_content user.email
    end
  end

  scenario 'User searches in all categoriesr', sphinx: true, js:true do
    visit new_search_path
    ThinkingSphinx::Test.run do
      select 'All', from: 'Select'
      fill_in 'search', with: 'MyText'
      click_on 'Search'
      expect(page).to have_content 'Answer'
      expect(page).to have_content 'Question'
      expect(page).to have_content 'Comment'
    end
  end
end
