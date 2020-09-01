require 'rails_helper'

RSpec.describe 'FollowUnfollow', js: true, type: :system do
  it 'can follow and unfollow other user' do
    test1 = create(:test1)
    test2 = create(:test2)
    log_in test1
    visit user_path(test2)
    click_button 'フォロー'
    expect(page).to have_button 'フォロー解除'
    relationship = Relationship.first
    expect(relationship.user_id).to eq test1.id
    expect(relationship.follow_id).to eq test2.id
    click_button 'フォロー解除'
    expect(page).to have_button 'フォロー'
    expect(Relationship.count).to eq 0
  end
end
