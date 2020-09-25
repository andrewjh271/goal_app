# == Schema Information
#
# Table name: goal_comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  goal_id    :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class GoalComment < ApplicationRecord
  validates :body, :goal_id, :author_id, presence: true

  belongs_to :goal
  belongs_to :author,
    class_name: :User,
    foreign_key: :author_id
end
