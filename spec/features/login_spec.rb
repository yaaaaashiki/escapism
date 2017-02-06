require 'rails_helper'

feature 'login page test' do
  # let(:user) { create(:user) }
  # let(:user) { User.first }

  background do
    visit "/login"
  end

  scenario 'user data is correct' do 
    skip '(T_T)' # userをcreateするたびに増える...
# binding.pry
    expect(user.id).to eq(1) 
  end 
  
  scenario 'when login and data should insert user db' do
    # データベースに保存(データ数が増加)
    # seedでユーザデータをEscapism_testデータベースにいれたほうが良いかも
    existedUser = create(:user)

    fill_in  'username', with: 'user1'
    fill_in  'password', with: 'password'
    click_on 'submit'

    expect(page).to have_content 'Dürst研論文検索'
  end
end


