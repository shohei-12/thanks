# ユーザー削除機能が必要であるかどうか検討中

# require 'rails_helper'

# RSpec.describe 'UsersDelete', js: true, type: :system do
#   before do
#     @test1 = create(:test1)
#     visit users_path
#   end

#   context 'when accept the confirmation dialog' do
#     before { accept_confirm { click_link '削除する' } }

#     it 'delete a user' do
#       expect(page).to have_current_path users_path
#       expect(User.count).to eq 0
#     end
#   end

#   context 'when dismiss the confirmation dialog' do
#     before { dismiss_confirm { click_link '削除する' } }

#     it 'do not delete a user' do
#       expect(page).to have_current_path users_path
#       expect(User.count).to eq 1
#     end
#   end
# end
