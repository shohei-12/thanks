require 'rails_helper'

RSpec.describe 'CommentsCreate', js: true, type: :system do
  before do
    @post1 = create(:post1)
    log_in @post1.user
    visit post_path(@post1)
  end

  it 'create a comment' do
    fill_in 'コメントを書く', with: 'テストコメント'
    click_button 'コメントする'
    expect(page).to have_selector '.comments p', text: 'テストコメント'
    expect(page).to have_selector '.comments .delete', text: '削除する'
  end
end
