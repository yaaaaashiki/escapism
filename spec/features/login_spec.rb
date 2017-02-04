require 'rails_helper'

feature 'loginpage test' do
  scenario 'when input login information, the data should insert userdb' do
    pending"anyway" 
    visit "/" 
    click_link 'Login'
    expect(response).to render_template :new 
  end
end


