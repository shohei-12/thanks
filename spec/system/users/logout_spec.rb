require 'rails_helper'

RSpec.describe 'UsersLogout', type: :system do
  before do
    @test1 = create(:test1)
  end

  context 'when the user is logged in' do
    before { log_in(@test1) }

    it 'log out' do
      visit user_path(@test1)
      click_link 'ログアウト'
      expect(page).to have_current_path root_path
      expect(page).to have_css '.danger-message'
      expect(page).to have_link 'ログイン', href: login_path
    end
  end

  context 'when the user is not logged in' do
    it 'cannot log out' do
      visit user_path(@test1)
      expect(page).not_to have_link 'ログアウト', href: logout_path
    end
  end
end
