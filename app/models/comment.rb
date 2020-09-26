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
class Comment < ApplicationRecord
  validates :body, :author_id, presence: true

  belongs_to :subject, polymorphic: true
  belongs_to :author,
    class_name: :User
end
