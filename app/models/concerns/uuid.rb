module Uuid
  extend ActiveSupport::Concern

  included do
    before_validation :set_uuid, on: :create
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
