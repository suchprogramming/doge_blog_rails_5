class Invitation < ApplicationRecord
  has_secure_token
  belongs_to :admin
  validates :recipient_email, presence: true

  before_create :mark_inactive
  after_create :set_expiration_date

  scope :valid_invite_token, -> (token) {
    where(token: token, expires_at: DateTime.now..DateTime.now + 1.day)
  }

  scope :active_user_invites, -> (recipient_email) {
    where(recipient_email: recipient_email).where.not(expires_at: nil)
  }

  def invite_link
    "administration/sign_up/#{token}"
  end

  private

  def set_expiration_date
    self.update_attributes(expires_at: DateTime.now + 1.day)
  end

  def mark_inactive
    Invitation.where(recipient_email: recipient_email).each do |inv|
      inv.update_attributes(accepted_at: DateTime.now, expires_at: nil)
    end
  end

end
