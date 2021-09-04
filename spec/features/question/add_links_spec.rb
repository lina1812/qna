require 'rails_helper'

feature 'User can add links to question', "
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/vkurennov/743f9367caa1039874af5a2244e1b44c' }
  given(:google_url) { 'https://google.com' }
  background do
    sign_in(user)
    visit new_question_path
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
  end
  
  scenario 'User adds link when asks question' do
    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    expect(page).to have_link 'My gist', href: gist_url
  end

  scenario 'User adds several links when give an answer', js: true do
    click_on 'add link'

    page.all(:fillable_field, 'Name').first.set('My gist')
    page.all(:fillable_field, 'Url').first.set(gist_url)
    page.all(:fillable_field, 'Name').last.set('Google')
    page.all(:fillable_field, 'Url').last.set(google_url)

    click_on 'Ask'

    within '.question' do
      expect(page).to have_link 'My gist', href: gist_url
      expect(page).to have_link 'Google', href: google_url
    end
  end
  
  scenario 'User adds link when asks question wit errors' do
    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: ''

    click_on 'Ask'

    expect(page).to have_content "Links url can't be blank"
    expect(page).to have_content "Links url is not a valid URL"
  end
end
