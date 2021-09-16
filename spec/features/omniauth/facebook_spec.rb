require 'rails_helper'

feature 'User can sign_up with Facebook', "
  As an unauthenticated user
  I'd like to be able to sing_up with Facebook
" do
  background do
    visit root_path
    click_on 'Sign Up'
  end

  given(:correct_mock) do
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
                                                                    'provider' => 'facebook',
                                                                    'uid' => '123545',
                                                                    'info' => {
                                                                      'name' => 'mockuser'
                                                                    }
                                                                  })
  end
  given(:incorrect_mock) do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  end
  scenario 'Correct login' do
    expect(page).to have_link 'Sign in with Facebook'

    correct_mock

    click_on 'Sign in with Facebook'

    fill_in 'Email', with: 'test@facebook.com'
    click_on 'Continue'

    visit root_path
    click_on 'Sign Up'
    click_on 'Sign in with Facebook'
    expect(page).not_to have_content 'Welcome,'

    open_email('test@facebook.com')
    current_email.click_link 'Confirm my account'

    click_on 'Sign Up'
    click_on 'Sign in with Facebook'
    expect(page).to have_content 'Welcome,'
  end

  scenario 'Incorrect login' do
    expect(page).to have_link 'Sign in with Facebook'

    incorrect_mock

    click_on 'Sign in with Facebook'

    expect(page).not_to have_content 'Welcome,'
  end
end
