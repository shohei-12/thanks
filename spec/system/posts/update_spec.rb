require 'rails_helper'

RSpec.describe 'PostsUpdate', type: :system do
  let(:test2) { create(:test2) }

  before { @post1 = create(:post1) }

  context 'when the user is logged in' do
    context 'when access the edit page of own post' do
      before do
        log_in(@post1.user)
        visit post_path(@post1)
        click_link '編集する'
      end

      context 'when post information is valid' do
        it 'update a post information' do
          fill_in 'タイトル', with: 'テスト'
          fill_in '内容', with: 'テストです。'
          click_button '更新する'
          @post1.reload
          expect(@post1.title).to eq 'テスト'
          expect(@post1.content).to eq 'テストです。'
        end
      end

      context 'when post information is invalid' do
        it 'do not update a post information' do
          fill_in 'タイトル', with: 'a' * 51
          fill_in '内容', with: 'a' * 401
          click_button '更新する'
          expect(page).to have_css '.error-message'
          @post1.reload
          expect(@post1.title).to eq @post1.title
          expect(@post1.content).to eq @post1.content
        end
      end
    end

    context 'when access the details page of others post' do
      it 'do not display edit link' do
        log_in(test2)
        visit post_path(@post1)
        expect(page).not_to have_link '編集する', href: edit_post_path(@post1)
      end
    end

    context 'when access the edit page of others post' do
      it 'redirect to the top page' do
        log_in(test2)
        visit edit_post_path(@post1)
        expect(current_path).to eq root_path
      end
    end
  end

  context 'when the user is not logged in' do
    it 'cannot access post edit page' do
      visit edit_post_path(@post1)
      expect(current_path).to eq login_path
    end
  end
end
