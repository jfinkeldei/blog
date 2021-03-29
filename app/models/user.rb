class User < ApplicationRecord
  has_secure_password
  has_many :articles
  has_many :comments

  validates_uniqueness_of :email
end
