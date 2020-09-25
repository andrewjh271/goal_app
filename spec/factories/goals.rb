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
FactoryBot.define do
  factory :goal do
    title { Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4) }
    user
  end
end

def user_with_goals(goal_count: 3)
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:goal, goal_count, user: user)
  end
end
