class User < ApplicationRecord
  NAME_FORMAT = /\A\w+\z/

  validates :name, :email, presence: true
  validates :name, format: { with: NAME_FORMAT }

  has_secure_password
end
