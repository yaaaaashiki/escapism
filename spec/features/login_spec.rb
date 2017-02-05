require 'rails_helper'

feature 'login page test' do
  scenario 'when input login information, the data should insert user db' do
    pending"anyway" 
    visit "/" 
    click_on 'Login'
    expect(response).to render_template :new 
  end
end


