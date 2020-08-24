require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post1) { build(:post1) }

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

  describe 'check' do
    context 'when check is invalid' do
      context 'when check is empty' do
        before { post1.check = '' }

        it 'return false' do
          expect(post1.valid?).to eq false
        end
      end

      context 'when check has an unexpected value' do
        before { post1.check = 2 }

        it 'return false' do
          expect(post1.valid?).to eq false
        end
      end
    end
  end

  describe '#self.search(keyword)' do
    before { @post1 = create(:post1) }

    context 'when posts containing keyword is exist' do
      it 'get posts containing keyword' do
        expect(Post.search('test').include?(@post1)).to eq true
      end
    end

    context 'when posts containing keyword is not exist' do
      it 'not get posts' do
        expect(Post.search('hoge').length).to eq 0
      end
    end
  end
end
