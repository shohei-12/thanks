require 'rails_helper'

RSpec.describe 'PostsCreate', type: :system do
  before { @test1 = create(:test1) }

  subject { page }

  context 'when the user is logged in' do
    before do
      log_in(@test1)
      visit new_post_path
    end

    context 'when post information is valid' do
      it 'create a post' do
        fill_in 'タイトル（50文字以内）', with: 'test'
        fill_in '内容（400文字以内）', with: 'testです。'
        expect { click_button '投稿する' }.to change(Post, :count).by(1)
      end
    end

    context 'when post information is invalid' do
      it 'do not create a post' do
        fill_in 'タイトル（50文字以内）', with: ''
        fill_in '内容（400文字以内）', with: ''
        expect { click_button '投稿する' }.to change(Post, :count).by(0)
        is_expected.to have_css '.error-messages'
      end
    end
  end

  context 'when the user is not logged in' do
    it 'cannot access post create page' do
      visit new_post_path
      is_expected.to have_current_path login_path
    end
  end
end
