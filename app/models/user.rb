# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  sessions_token  :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_many :cats

  validates :user_name, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :user_name, uniqueness: true
  attr_reader :password

  after_initialize :generate_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil if user.nil?
    if user.is_password?(password)
      return user
    end
    nil
  end

  def generate_session_token
    self.sessions_token ||= SecureRandom::urlsafe_base64
  end
  def reset_session_token!
    self.sessions_token = SecureRandom::urlsafe_base64
  end
end
