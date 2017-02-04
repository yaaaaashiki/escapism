require 'rails_helper'

feature 'rootpage test' do

  scenario 'when clicking login link, jump to correctlink' do
    skip
    visit "/" 
    click_link 'Login'
    expect(response).to render_template :new 
  end

  scenario 'render user#index' do
    skip
    visit "/" 
    get :index 
    expect(response).to render_template :index 
  end

end
