require 'rails_helper'

RSpec.describe 'UsersLogin', type: :system do
  let(:test1) { create(:test1) }

  before { visit login_path }

  subject { page }

  context 'when login information is correct' do
    it 'log in' do
      fill_in 'メールアドレス', with: test1.email
      fill_in 'パスワード', with: test1.password
      click_button 'ログインする'
      is_expected.to have_current_path user_path(test1)
      is_expected.to have_css '.success-message'
      is_expected.to have_link 'ログアウト', href: logout_path
    end
  end

  context 'when login information is incorrect' do
    it 'not log in' do
      fill_in 'メールアドレス', with: 'incorrect@gmail.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
      is_expected.to have_css '.danger-message'
      is_expected.to have_link 'ログイン', href: login_path
    end
  end

  context 'when click on easy Login' do
    it 'log in as a guest user' do
      guest = create(:guest)
      click_link 'かんたんログイン'
      is_expected.to have_current_path user_path(guest)
      is_expected.to have_css '.success-message'
      is_expected.to have_link 'ログアウト', href: logout_path
    end
  end
end
