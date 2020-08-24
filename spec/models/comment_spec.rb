require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment1) { build(:comment1) }

  describe 'content' do
    context 'when content is invalid' do
      context 'when content is empty' do
        before { comment1.content = '' }

        it 'return false' do
          expect(comment1.valid?).to eq false
        end
      end

      context 'when content is over 400 characters' do
        before { comment1.content = 'a' * 401 }

        it 'return false' do
          expect(comment1.valid?).to eq false
        end
      end
    end
  end
end
