require 'rails_helper'

RSpec.describe User, type: :model do
  let(:test1) { build(:test1) }
  let(:test2) { build(:test2) }
  let(:test3) { create(:test1) }
  let(:test4) { create(:test2) }

  describe 'name' do
    context 'when name is invalid' do
      context 'when name is empty' do
        before { test1.name = '' }

        it 'return false' do
          expect(test1.valid?).to eq false
        end
      end

      context 'when name is over 50 characters' do
        before { test1.name = 'a' * 51 }

        it 'return false' do
          expect(test1.valid?).to eq false
        end
      end
    end
  end

  describe 'email' do
    context 'when email is invalid' do
      context 'when email is empty' do
        before { test1.email = '' }

        it 'return false' do
          expect(test1.valid?).to eq false
        end
      end

      context 'when email is duplicated' do
        before { create(:test1) }

        it 'return false' do
          expect(test1.valid?).to eq false
        end
      end

      context 'when email is over 256 characters' do
        before { test1.email = 'a' * 247 + '@example.com' }

        it 'return false' do
          expect(test1.valid?).to eq false
        end
      end

      context 'when email is an invalid format' do
        it 'return false' do
          [
            'user＠example.com',
            'userexample.com',
            'user@example..com',
            'user@.example.com',
            'user@example.com-'
          ].each do |invalid_email|
            test1.email = invalid_email
            expect(test1.valid?).to eq false
          end
        end
      end
    end
  end

  describe 'password' do
    context 'when password is invalid' do
      context 'when password is empty' do
        before do
          test1.password = ''
          test1.password_confirmation = ''
        end

        it 'return false' do
          expect(test1.valid?).to eq false
        end
      end

      context 'when password and confirmation password do not match' do
        before { test1.password_confirmation = 'foobar' }

        it 'return false' do
          expect(test1.valid?).to eq false
        end
      end

      context 'when password is less than 6 characters' do
        before do
          test1.password = 'hoge'
          test1.password_confirmation = 'hoge'
        end

        it 'return false' do
          expect(test1.valid?).to eq false
        end
      end

      context 'when password is an invalid format' do
        it 'return false' do
          [
            'あいうえおか',
            'アイウエオカ',
            'foobar*',
            'foobar?',
            ':foobar'
          ].each do |invalid_password|
            test1.password = invalid_password
            test1.password_confirmation = invalid_password
            expect(test1.valid?).to eq false
          end
        end
      end
    end
  end

  describe '#self.new_token' do
    it 'return a random token' do
      expect(User.new_token).to be_truthy
    end
  end

  describe '#self.digest(string)' do
    it 'return a hash value of the passed string' do
      expect(User.digest(User.new_token)).to be_truthy
    end
  end

  describe '#remember' do
    it 'update remember_digest' do
      test1.remember
      expect(test1.remember_digest).not_to eq nil
    end
  end

  describe '#authenticated?(remember_token)' do
    context 'when remember_digest is not nil' do
      before { test1.remember }

      context 'when remember_token and remember_digest match' do
        it 'return true' do
          expect(test1.authenticated?(test1.remember_token)).to eq true
        end
      end

      context 'when remember_token and remember_digest do not match' do
        it 'return false' do
          expect(test1.authenticated?(User.digest(User.new_token))).to eq false
        end
      end

      context 'when remember_token is nil' do
        it 'return false' do
          expect(test1.authenticated?(nil)).to eq false
        end
      end
    end

    context 'when remember_digest is nil' do
      it 'return false' do
        expect(test1.authenticated?(User.digest(User.new_token))).to eq false
      end
    end
  end

  describe '#forget' do
    it 'set remember_digest to nil' do
      test1.remember
      test1.forget
      expect(test1.remember_digest).to eq nil
    end
  end

  describe '#follow(user)' do
    context 'when user is exist' do
      context 'when user is other user' do
        it 'follow a user' do
          test3.follow(test4)
          relationship = Relationship.first
          expect(relationship.user_id).to eq test3.id
          expect(relationship.follow_id).to eq test4.id
        end
      end

      context 'when user is own' do
        it 'return nil' do
          expect(test3.follow(test3)).to eq nil
        end
      end
    end

    context 'when user is not exist' do
      it 'raises NoMethodError' do
        test3.follow(nil)
      rescue StandardError
      end
    end
  end

  describe '#unfollow(user)' do
    context 'when user is exist' do
      context 'when following a user' do
        before do
          test3.follow(test4)
          expect(Relationship.count).to eq 1
        end

        it 'unfollow a user' do
          test3.unfollow(test4)
          expect(Relationship.count).to eq 0
        end
      end

      context 'when not following a user' do
        it 'return nil' do
          expect(test3.unfollow(test4)).to eq nil
        end
      end
    end

    context 'when user is not exist' do
      it 'raises NoMethodError' do
        test3.unfollow(nil)
      rescue StandardError
      end
    end
  end

  describe '#following?(user)' do
    context 'when user is exist' do
      context 'when following a user' do
        before { test3.follow(test4) }

        it 'return true' do
          expect(test3.following?(test4)).to eq true
        end
      end

      context 'when not following a user' do
        it 'return false' do
          expect(test3.following?(test4)).to eq false
        end
      end
    end

    context 'when user is not exist' do
      it 'return false' do
        expect(test3.following?(nil)).to eq false
      end
    end
  end
end
