require 'rails_helper'

RSpec.describe 'UsersUpdate', type: :system do
  before { @test1 = create(:test1) }

  context 'when the user is logged in' do
    before do
      log_in(@test1)
      visit edit_user_path(@test1)
    end

    context 'when user information is valid' do
      it 'update a user information' do
        fill_in 'ユーザー名', with: 'test1-update'
        fill_in 'メールアドレス', with: 'test1-update@example.com'
        fill_in 'パスワード', with: 'foobar'
        fill_in '確認用パスワード', with: 'foobar'
        click_button '更新する'
        @test1.reload
        expect(@test1.name).to eq 'test1-update'
        expect(@test1.email).to eq 'test1-update@example.com'
        expect(@test1.authenticate('foobar')).to be_truthy
      end
    end

    context 'when user information is invalid' do
      it 'do not update a user information' do
        fill_in 'ユーザー名', with: ''
        fill_in 'メールアドレス', with: 'testexample.com'
        fill_in 'パスワード', with: 'hoge'
        fill_in '確認用パスワード', with: 'hoge'
        click_button '更新する'
        @test1.reload
        expect(@test1.name).to eq 'test1'
        expect(@test1.email).to eq 'test1@example.com'
        expect(@test1.authenticate('password')).to be_truthy
        expect(page).to have_css '.error-message'
      end
    end
  end

  context 'when the user is not logged in' do
    it 'cannot access edit page' do
      visit edit_user_path(@test1)
      expect(page).to have_current_path login_path
    end
  end
end
