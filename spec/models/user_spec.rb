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

  end

end
