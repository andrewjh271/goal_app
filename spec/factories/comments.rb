# == Schema Information
#
# Table name: comments
#
#  id           :bigint           not null, primary key
#  body         :text             not null
#  subject_type :string           not null
#  subject_id   :bigint           not null
#  author_id    :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  # defaults to comment on a user
  factory :comment do
    body { 'A generic comment.' }
    subject { create(:user) }
    author { create(:user) }
  end
end
