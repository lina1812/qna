require 'rails_helper'

feature 'User can sign_up with Google', "
  As an unauthenticated user
  I'd like to be able to sing_up with Google
" do

  background do
    visit root_path
    click_on 'Sign Up'
  end
  
  given(:correct_mock) {
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      'provider' => 'google_oauth2',
      'uid' => '123545',
      'info' => {
        'email' => 'mockuser@gmail.com'
      }
    })
  }
  given(:incorrect_mock) {
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
  }
  scenario 'Correct login' do
    expect(page).to have_link 'Sign in with GoogleOauth2'

    correct_mock

    click_on 'Sign in with GoogleOauth2'
    expect(page).to have_content 'Welcome,'
  end
  
  scenario 'Incorrect login' do
    expect(page).to have_link 'Sign in with GoogleOauth2'

    incorrect_mock

    click_on 'Sign in with GoogleOauth2'

    expect(page).not_to have_content 'Welcome,'
  end
end
