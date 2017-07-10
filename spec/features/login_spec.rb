require 'rails_helper'

feature 'login page test' do
  let(:user) { create(:user) }

  background do
    visit "/login"
  end
 
  scenario 'when login and data should insert user db' do
    fill_in  'username', with: user.username 
    fill_in  'password', with: 'password'
    click_on 'submit'

    expect(page).to have_content "Dürst研論文検索"
  end

  scenario 'login' do
    login_user_post user, sessions_url
    visit "/search" 
    
    expect(page).to have_content "Dürst研論文検索"
  end
end



