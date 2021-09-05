require 'rails_helper'

feature 'User can add links to question', "
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given(:github_url) { 'https://github.com/' }
  given(:google_url) { 'https://google.com' }
  background do
    sign_in(user)
    visit new_question_path
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
  end

  scenario 'User adds link when asks question' do
    fill_in 'Name', with: 'GitHub'
    fill_in 'Url', with: github_url

    click_on 'Ask'

    expect(page).to have_link 'GitHub', href: github_url
  end

  scenario 'User adds several links when give an answer', js: true do
    click_on 'add link'

    page.all(:fillable_field, 'Name').first.set('GitHub')
    page.all(:fillable_field, 'Url').first.set(github_url)
    page.all(:fillable_field, 'Name').last.set('Google')
    page.all(:fillable_field, 'Url').last.set(google_url)

    click_on 'Ask'

    within '.question' do
      expect(page).to have_link 'GitHub', href: github_url
      expect(page).to have_link 'Google', href: google_url
    end
  end

  scenario 'User adds link when asks question wit errors' do
    fill_in 'Name', with: 'GitHub'
    fill_in 'Url', with: ''

    click_on 'Ask'

    expect(page).to have_content "Links url can't be blank"
    expect(page).to have_content 'Links url is not a valid URL'
  end
end
