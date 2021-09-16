require 'rails_helper'

feature 'User can sign up', "
  In order to use system fully
  As an authenticated user
  I'd like to be able to sign up
" do
  background { visit root_path }

  scenario 'New user tries to sign up' do
    expect(page).to have_link 'Sign Up'
    click_on 'Sign Up'

    expect(page).to have_content 'Sign up'
    fill_in 'Email', with: 'new_user@example.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'A message with a confirmation link has been sent to your email address.'

    open_email('new_user@example.com')
    current_email.click_link 'Confirm my account'

    expect(page).to have_content 'Your email address has been successfully confirmed.'

    click_on 'Sign In'
    fill_in 'Email', with: 'new_user@example.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'Welcome, new_user@example.com'
  end

  scenario 'New user tries to sign up with diferent password and pasword comfirmation' do
    expect(page).to have_link 'Sign Up'
    click_on 'Sign Up'
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario 'New user tries to sign up with wrong' do
    expect(page).to have_link 'Sign Up'
    click_on 'Sign Up'

    click_on 'Sign up'

    expect(page).to have_content 'prohibited this user from being saved'
  end

  scenario 'New user tries to sign up with occupied email ' do
    create(:user, email: 'user@example.com')
    expect(page).to have_link 'Sign Up'
    click_on 'Sign Up'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'
    expect(page).to have_content 'Email has already been taken'
  end
end
