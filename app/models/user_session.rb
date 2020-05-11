class UserSession < ApplicationRecord
  include Uuid

  belongs_to :user

  validates :uuid, presence: true
end
