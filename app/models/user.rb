class User < ApplicationRecord
  validates :name, :email, presence: true

  has_secure_password
end
