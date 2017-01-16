class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :password_digest, :email
  validates :username, uniqueness: true, length: { in: 3..16 }
  validates :password_digest, length: { minimum: 3 }
end
