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
class User < ApplicationRecord
  attr_reader :password

  validates :username, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password_digest, presence: { message: 'Password can\'t be blank' }
  validates :password, length: { minimum: 6 }

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    update(session_token: generate_session_token)
    session_token
  end

  private

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64
  end

end
