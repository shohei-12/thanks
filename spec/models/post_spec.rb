require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post1) { build(:post1) }

  describe 'post1' do
    context 'when post1 is a valid post' do
      it 'return true' do
        expect(post1.valid?).to eq true
      end
    end
  end

  describe 'title' do
    context 'when title is invalid' do
      context 'when title is empty' do
        before { post1.title = '' }

        it 'return false' do
          expect(post1.valid?).to eq false
        end
      end

      context 'when title is over 50 characters' do
        before { post1.title = 'a' * 51 }

        it 'return false' do
          expect(post1.valid?).to eq false
        end
      end
    end
  end

  describe 'content' do
    context 'when content is invalid' do
      context 'when content is empty' do
        before { post1.content = '' }

        it 'return false' do
          expect(post1.valid?).to eq false
        end
      end

      context 'when content is over 400 characters' do
        before { post1.content = 'a' * 401 }

        it 'return false' do
          expect(post1.valid?).to eq false
        end
      end
    end
  end
end
