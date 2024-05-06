# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject(:user) { FactoryBot.build(:user) }

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }

    context 'before validations' do
      it 'should set password_digest' do
        expect(user.password_digest).not_to be nil
      end
  
      it 'should set session_token' do
        expect(user.session_token).not_to be nil
      end
    end
  end

  describe 'associations' do
    it { should have_many(:goals) }
  end

  describe 'class methods' do
    describe '::find_by_credentials' do
      subject(:user) { FactoryBot.create(:user) }

      it 'should find the user with matching credentials' do
        expect(User.find_by_credentials(user.username, user.password)).to eq(user)
      end

      it 'should return nil if  no matching credentials exist' do
        expect(User.find_by_credentials(user.username, 'password')).to be_nil
      end

    end
  end

  describe 'instance methods' do
    subject(:user) { FactoryBot.build(:user) }
    
    describe '#is_password?' do
      it 'returns true if argument is correct password' do
        user.password = 'password'
        expect(user.is_password?('password')).to be(true)
      end

      it 'returns false if argument is incorrect password' do
        expect(user.is_password?('very_unlikely')).to be(false)
      end
    end

    describe '#reset_session_token!' do
      it 'resets session token for a user' do
        old_token = user.session_token
        user.reset_session_token!
        expect(user.session_token).not_to eq(old_token)
      end

      it 'returns new session token' do
        expect(user.reset_session_token!).to eq(user.session_token)
      end
    end
  end
end
