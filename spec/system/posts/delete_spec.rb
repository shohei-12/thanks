require 'rails_helper'

RSpec.describe 'PostsDelete', js: true, type: :system do
  before { @post1 = create(:post1) }

  context 'when the user is logged in' do
    context 'when access the details page of own post' do
      before do
        log_in(@post1.user)
        visit post_path(@post1)
      end

      context 'when accept the confirmation dialog' do
        before { accept_confirm { click_link '削除する' } }

        it 'delete a post' do
          expect(current_path).to eq user_path(@post1.user)
          expect(Post.count).to eq 0
        end
      end

      context 'when dismiss the confirmation dialog' do
        before { dismiss_confirm { click_link '削除する' } }

        it 'do not delete a post' do
          expect(current_path).to eq post_path(@post1)
          expect(Post.count).to eq 1
        end
      end
    end

    context 'when access the details page of others post' do
      it 'do not display delete link' do
        log_in(create(:test2))
        visit post_path(@post1)
        expect(page).not_to have_link '削除する', href: post_path(@post1)
      end
    end
  end

  context 'when the user is not logged in' do
    it 'cannot access post details page' do
      visit post_path(@post1)
      expect(current_path).to eq login_path
    end
  end
end
