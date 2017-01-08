class Invitation < ApplicationRecord
  has_secure_token
  belongs_to :admin
  validates :recipient_email, presence: true

  scope :active_invites, -> (recipient_email) {
    where(recipient_email: recipient_email, active: true)
  }

  def mark_accepted
    self.update_attributes(active: false, accepted_at: Time.now)
  end

  def invite_link
    "admins/sign_up/#{token}"
  end

end
