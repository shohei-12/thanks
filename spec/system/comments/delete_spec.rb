require 'rails_helper'

RSpec.describe 'CommentsDelete', js: true, type: :system do
  let(:test2) { create(:test2) }

  before do
    @test1 = create(:test1)
    @post1 = create(:post1, user_id: @test1.id)
    @comment1 = create(:comment1, user_id: @test1.id, post_id: @post1.id)
  end

  context 'when the user is logged in' do
    context 'when commenter is current user' do
      before do
        log_in @comment1.user
        visit post_path(@comment1.post)
      end

      context 'when accept the confirmation dialog' do
        before do
          within '.comments' do
            accept_confirm { click_link '削除する' }
          end
        end

        it 'delete a comment' do
          expect(page).not_to have_selector '.comments li p', text: @comment1.content
          expect(page).not_to have_selector '.comments li a', text: '削除する'
          expect(Comment.count).to eq 0
        end
      end

      context 'when dismiss the confirmation dialog' do
        before do
          within '.comments' do
            dismiss_confirm { click_link '削除する' }
          end
        end

        it 'do not delete a comment' do
          expect(page).to have_selector '.comments li p', text: @comment1.content
          expect(page).to have_selector '.comments li a', text: '削除する'
          expect(Comment.count).to eq 1
        end
      end
    end

    context 'when commenter is not current user' do
      before do
        log_in test2
        visit post_path(@comment1.post)
      end

      it 'cannot delete a comment' do
        expect(page).not_to have_selector '.comments li a', text: '削除する'
      end
    end
  end

  context 'when the user is not logged in' do
    it 'cannot delete a comment' do
      visit post_path(@comment1.post)
      expect(page).to have_current_path login_path
    end
  end
end
