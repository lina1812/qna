require 'rails_helper'

feature 'User can sign out', %q{
  An authenticated user
  I'd like to be able to sign out
} do

  given(:user) { create(:user) }
   

  scenario 'Logged in user tries to sign out' do
    sign_in(user)
    visit root_path
    expect(page).to have_link 'Sign Out'
    
    click_on 'Sign Out'
    expect(page).to have_content 'Signed out successfully.'
  end
  
  scenario 'Unlogged in user tries to sign out' do
    visit root_path
    expect(page).not_to have_link 'Sign Out'
  end
end