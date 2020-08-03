require 'rails_helper'

RSpec.describe 'PostsUpdate', type: :system do
  before { @post1 = create(:post1) }

  context 'when the user is logged in' do
    before do
      log_in(@post1.user)
      visit edit_post_path(@post1)
    end

    context 'when post information is valid' do
      it 'update a post information' do
        fill_in 'タイトル（50文字以内）', with: 'テスト'
        fill_in '内容（400文字以内）', with: 'テストです。'
        click_button '更新する'
        @post1.reload
        expect(@post1.title).to eq 'テスト'
        expect(@post1.content).to eq 'テストです。'
      end
    end

    context 'when post information is invalid' do
      it 'do not update a post information' do
        fill_in 'タイトル（50文字以内）', with: ''
        fill_in '内容（400文字以内）', with: ''
        click_button '更新する'
        @post1.reload
        expect(@post1.title).to eq @post1.title
        expect(@post1.content).to eq @post1.content
        expect(page).to have_css '.error-message'
      end
    end
  end

  context 'when the user is not logged in' do
    it 'cannot access post edit page' do
      visit edit_post_path(@post1)
      expect(page).to have_current_path login_path
    end
  end
end
