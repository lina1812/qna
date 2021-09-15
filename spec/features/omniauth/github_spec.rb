require 'rails_helper'

feature 'User can sign_up with Github', "
  As an unauthenticated user
  I'd like to be able to sing_up with Github
" do

  background do
    visit root_path
    click_on 'Sign Up'
  end
  
  given(:correct_mock) {
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      'provider' => 'github',
      'uid' => '123545',
      'info' => {
        'email' => 'mockuser@github.com'
      }
    })
  }
  given(:incorrect_mock) {
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
  }
  scenario 'Correct login' do
    expect(page).to have_link 'Sign in with GitHub'

    correct_mock

    click_on 'Sign in with GitHub'
    expect(page).to have_content 'Welcome,'
  end
  
  scenario 'Incorrect login' do
    expect(page).to have_link 'Sign in with GitHub'

    incorrect_mock

    click_on 'Sign in with GitHub'

    expect(page).not_to have_content 'Welcome,'
  end
end
