require 'rails_helper'

RSpec.describe 'UsersLogin', type: :system do
  let(:test1) { create(:test1) }

  before { visit login_path }

  context 'when login information is correct' do
    it 'log in' do
      fill_in 'メールアドレス', with: test1.email
      fill_in 'パスワード', with: test1.password
      click_button 'ログイン'
      expect(current_path).to eq user_path(test1)
      expect(page).to have_css '.success-message'
      expect(page).to have_link 'ログアウト', href: logout_path
    end
  end

  context 'when login information is incorrect' do
    it 'not log in' do
      fill_in 'メールアドレス', with: 'incorrect@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      expect(page).to have_css '.danger-message'
      expect(page).to have_link 'ログイン', href: login_path
    end
  end

  context 'when click on easy Login' do
    it 'log in as a guest user' do
      guest = create(:guest)
      click_link 'かんたんログイン'
      expect(current_path).to eq user_path(guest)
      expect(page).to have_css '.success-message'
      expect(page).to have_link 'ログアウト', href: logout_path
    end
  end
end
