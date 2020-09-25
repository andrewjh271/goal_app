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
class Goal < ApplicationRecord
  attribute :completed, :boolean, default: false
  attribute :secret, :boolean, default: false

  validates :title, :user_id, presence: true
  validates :title, uniqueness: { scope: :user_id }
  validates :completed, inclusion: { in: [true, false] }

  belongs_to :user
end
