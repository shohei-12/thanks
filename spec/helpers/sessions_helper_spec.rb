require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:test1) { create(:test1) }

  describe '#log_in(user)' do
    it 'log in with the given user' do
      log_in(test1)
      expect(session[:user_id]).to eq test1.id
    end
  end

  describe '#logged_in?' do
    context 'when the user is logged in' do
      before { log_in(test1) }

      it 'return true' do
        expect(logged_in?).to eq true
      end
    end

    context 'when the user is not logged in' do
      it 'return false' do
        expect(logged_in?).to eq false
      end
    end
  end

  describe '#current_user' do
    context 'when there is a session' do
      before { log_in(test1) }

      it 'return the logged in user' do
        expect(current_user).to eq test1
      end
    end

    context 'when there is not a session' do
      context 'when there is a cookie' do
        before { remember test1 }

        it 'return the logged in user' do
          expect(current_user).to eq test1
        end
      end

      context 'when there is not a cookie' do
        it 'return nil' do
          expect(current_user).to eq nil
        end
      end
    end
  end

  describe '#log_out' do
    context 'when the user is logged in' do
      before { remember test1 }

      it 'log out the current user' do
        log_out
        expect(test1.reload.remember_digest).to eq nil
        expect(cookies.signed[:user_id]).to eq nil
        expect(cookies[:remember_token]).to eq nil
        expect(session[:user_id]).to eq nil
      end
    end

    context 'when the user is not logged in' do
      it 'raises NoMethodError' do
        log_out
      rescue StandardError
      end
    end
  end

  describe '#remember(user)' do
    context 'when the given user is exist' do
      it 'save login status' do
        remember test1
        expect(test1.authenticated?(test1.remember_token)).to eq true
        expect(cookies.signed[:user_id]).to eq test1.id
        expect(cookies[:remember_token]).to eq test1.remember_token
      end
    end

    context 'when the given user is not exist' do
      it 'raises NoMethodError' do
        remember nil
      rescue StandardError
      end
    end
  end

  describe '#forget(user)' do
    context 'when the given user is exist' do
      context 'when the given user is logged in' do
        before { remember test1 }

        it 'break a persistent session' do
          forget test1
          expect(test1.reload.remember_digest).to eq nil
          expect(cookies.signed[:user_id]).to eq nil
          expect(cookies[:remember_token]).to eq nil
        end
      end
    end

    context 'when the given user is not exist' do
      it 'raises NoMethodError' do
        forget nil
      rescue StandardError
      end
    end
  end
end
