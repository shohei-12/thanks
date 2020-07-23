require 'rails_helper'

RSpec.describe User, type: :model do
  let(:test1) { build(:test1) }

  describe 'test1' do
    context 'when test1 is a valid user' do
      it 'return true' do
        expect(test1.valid?).to eq true
      end
    end
  end

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
        before { test1.email = 'a' * 247 + '@gmail.com' }

        it 'return false' do
          expect(test1.valid?).to eq false
        end
      end

      context 'when email is an invalid format' do
        it 'return false' do
          [
            'user＠gmail.com',
            'usergmail.com',
            'user@gmail..com',
            'user@.gmail.com',
            'user@gmail.com-'
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
end
