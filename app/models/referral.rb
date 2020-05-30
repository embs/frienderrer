class Referral < ApplicationRecord
  belongs_to :user

  scope :for, ->(user) { where(user: user) }
end
