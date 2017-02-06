require 'rails_helper'

feature 'login page test' do

  let(:user) { User.first }
               #user(:create)

  scenario 'user data is correct' do 
#binding.pry
    expext(user.id).to eq(1) 

  end 
  
  scenario 'when login and data should insert user db' do
    pending"anyway" 
    visit "/login" 
    expect(response).to render_template :new 
  end
end


