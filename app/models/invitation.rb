class Invitation < ApplicationRecord
  has_secure_token
  belongs_to :admin
  validates :recipient_email, presence: true
end
