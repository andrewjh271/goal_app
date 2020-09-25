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
#
require 'rails_helper'

RSpec.describe Goal, type: :model do
  subject(:goal) { FactoryBot.build(:goal) }
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
