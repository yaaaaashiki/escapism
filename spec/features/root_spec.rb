require 'rails_helper'

feature 'rootpage test' do
  background do
    visit "/"
  end

#  scenario 'render user#index' do
#    expect(page).to have_content 'Dürst 研究室 論文検索システム ´▽｀)/'
#  end
#
#  scenario 'when clicking login link, jump to correctlink' do
#    click_on 'Login'
#    expect(page).to have_content 'Sign In'
#  end
end
