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
FactoryBot.define do
  factory :user_comment do
    body { "Good luck on all your goals." }
    user
    author { create(:user) }
  end
end
