require 'rails_helper'

RSpec.describe 'UsersSignup', type: :system do
  before { visit new_user_path }

  context 'when user information is valid' do
    it 'signup a user' do
      fill_in 'ユーザー名', with: 'test'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'password'
      expect { click_button '登録する' }.to change(User, :count).by(1)
    end
  end

  context 'when user information is invalid' do
    it 'do not signup a user' do
      fill_in 'ユーザー名', with: 'a' * 51
      fill_in 'メールアドレス', with: 'test@examplecom'
      fill_in 'パスワード', with: 'password'
      fill_in '確認用パスワード', with: 'pasword'
      expect { click_button '登録する' }.to change(User, :count).by(0)
      expect(page).to have_css '.error-message'
    end
  end
end
