class User < ApplicationRecord
  has_secure_password

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email, :case_sensitive => false

  enum role: ['user', 'admin']
end
