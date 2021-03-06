# == Schema Information
#
# Table name: user_comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  user_id    :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserComment < ApplicationRecord
  validates :body, :user_id, :author_id, presence: true

  belongs_to :user
  belongs_to :author,
    class_name: :User,
    foreign_key: :author_id
end
