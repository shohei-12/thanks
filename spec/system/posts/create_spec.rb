require 'rails_helper'

RSpec.describe 'PostsCreate', type: :system do
  before do
    @test1 = create(:test1)
    create(:category1)
  end

  context 'when the user is logged in' do
    before do
      log_in(@test1)
      visit new_post_path
    end

    context 'when post information is valid' do
      it 'create a post' do
        fill_in 'タイトル', with: 'test'
        select 'お父さん・お母さん', from: 'post_category_id'
        fill_in '内容', with: 'testです。'
        choose 'はい'
        choose '公開する'
        expect { click_button '投稿する' }.to change(Post, :count).by(1)
      end
    end

    context 'when post information is invalid' do
      it 'do not create a post' do
        fill_in 'タイトル', with: 'a' * 51
        select 'お父さん・お母さん', from: 'post_category_id'
        fill_in '内容', with: 'a' * 401
        choose 'はい'
        choose '公開する'
        expect { click_button '投稿する' }.to change(Post, :count).by(0)
        expect(page).to have_css '.error-message'
      end
    end
  end

  context 'when the user is not logged in' do
    it 'cannot access post create page' do
      visit new_post_path
      expect(current_path).to eq login_path
    end
  end
end
