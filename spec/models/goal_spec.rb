# == Schema Information
#
# Table name: goals
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  completed  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  secret     :boolean          default(FALSE), not null
#
require 'rails_helper'

RSpec.describe Goal, type: :model do
  subject(:goal) { FactoryBot.build(:goal) }
  describe 'validations' do
    it { should validate_presence_of(:title) }
    # it { should validate_presence_of(:secret) }
    # avoid validating presence of :secret because the database is set to 
    # assign a default value of false
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
    # it { should validate_inclusion_of(:completed).in_array([true, false]) }
    # Rspec gives the following reason for avoiding this test:
    # You are using `validate_inclusion_of` to assert that a boolean column
    # allows boolean values and disallows non-boolean ones. Be aware that it
    # is not possible to fully test this, as boolean columns will
    # automatically convert non-boolean values to boolean ones. Hence, you
    # should consider removing this test.
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
