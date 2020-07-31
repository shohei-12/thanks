require 'rails_helper'

RSpec.describe 'LikeUnlike', js: true, type: :system do
  before do
    @test1 = create(:test1)
    @post1 = create(:post1, user_id: @test1.id)
    @comment1 = create(:comment1, user_id: @test1.id, post_id: @post1.id)
    log_in @test1
    visit post_path(@post1)
  end

  it 'like and unlike a post' do
    within "#post-like-#{@post1.id}" do
      find('.far').click
      expect(page).to have_css '.fas'
    end
    like = Like.first
    expect(like.user_id).to eq @test1.id
    expect(like.post_id).to eq @post1.id
    within "#post-like-#{@post1.id}" do
      find('.fas').click
      expect(page).to have_css '.far'
    end
    expect(Like.count).to eq 0
  end

  it 'like and unlike a comment' do
    within "#comment-like-#{@comment1.id}" do
      find('.far').click
      expect(page).to have_css '.fas'
    end
    like = Like.first
    expect(like.user_id).to eq @test1.id
    expect(like.comment_id).to eq @comment1.id
    within "#comment-like-#{@comment1.id}" do
      find('.fas').click
      expect(page).to have_css '.far'
    end
    expect(Like.count).to eq 0
  end
end
