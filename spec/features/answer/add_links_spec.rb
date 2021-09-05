require 'rails_helper'

feature 'User can add links to answer', "
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
" do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:github_url) { 'https://github.com/' }
  given(:google_url) { 'https://google.com' }
  background do
    sign_in(user)
    visit question_path(question)
    fill_in 'answer_body', with: 'My answer'
  end

  scenario 'User adds link when give an answer', js: true do
    fill_in 'Name', with: 'GitHub'
    fill_in 'Url', with: github_url

    click_on 'Publish'

    within '.answers' do
      expect(page).to have_link 'GitHub', href: github_url
    end
  end

  scenario 'User adds link when give an answer with errors', js: true do
    fill_in 'Name', with: 'GitHub'
    fill_in 'Url', with: ''

    click_on 'Publish'

    expect(page).to have_content "Links url can't be blank"
    expect(page).to have_content 'Links url is not a valid URL'
  end

  scenario 'User adds several links when give an answer', js: true do
    click_on 'add link'
    page.all(:fillable_field, 'Name').first.set('GitHub')
    page.all(:fillable_field, 'Url').first.set(github_url)
    page.all(:fillable_field, 'Name').last.set('Google')
    page.all(:fillable_field, 'Url').last.set(google_url)
    click_on 'Publish'

    within '.answers' do
      expect(page).to have_link 'GitHub', href: github_url
      expect(page).to have_link 'Google', href: google_url
    end
  end
end
