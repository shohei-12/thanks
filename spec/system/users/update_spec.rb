require 'rails_helper'

RSpec.describe 'UsersUpdate', type: :system do
  before { @test1 = create(:test1) }

  subject { page }

  context 'when the user is logged in' do
    before do
      log_in(@test1)
      visit edit_user_path(@test1)
    end

    context 'when user information is valid' do
      it 'update a user information' do
        fill_in 'ユーザー名（50文字以内）', with: 'test1-update'
        fill_in 'メールアドレス', with: 'test1-update@gmail.com'
        fill_in 'パスワード（6文字以上）', with: 'foobar'
        fill_in '確認用パスワード', with: 'foobar'
        click_button '登録する'
        @test1.reload
        expect(@test1.name).to eq 'test1-update'
        expect(@test1.email).to eq 'test1-update@gmail.com'
        expect(@test1.authenticate('foobar')).to be_truthy
      end
    end

    context 'when user information is invalid' do
      it 'do not update a user information' do
        fill_in 'ユーザー名（50文字以内）', with: ''
        fill_in 'メールアドレス', with: 'testgmail.com'
        fill_in 'パスワード（6文字以上）', with: 'hoge'
        fill_in '確認用パスワード', with: 'hoge'
        click_button '登録する'
        @test1.reload
        expect(@test1.name).to eq 'test1'
        expect(@test1.email).to eq 'test1@gmail.com'
        expect(@test1.authenticate('password')).to be_truthy
        is_expected.to have_css '.error-messages'
      end
    end
  end

  context 'when the user is not logged in' do
    it 'cannot access edit page' do
      visit edit_user_path(@test1)
      is_expected.to have_current_path login_path
    end
  end
end
