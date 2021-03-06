class Admin < ApplicationRecord
  include Filterable
  include PolymorphicResourceHelper
  attr_accessor :token

  has_many :comments, as: :commentable
  has_many :invitations
  has_many :posts, as: :postable
  has_attached_file :avatar,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "default-avatar_:style.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]
  validates_attachment_size :avatar, in: 0..1.megabytes

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true, length: { maximum: 12 }
  validate :verify_invite, on: :new_invitation

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    true
  end

  def self.admin_search(term)
    term ? where('email ILIKE ?', "%#{term}%") : all
  end

  private

  def verify_invite
    invalid_invite if Invitation.where(valid_invite_params).empty?
  end

  def valid_invite_params
    {
      recipient_email: email,
      token: token,
      expires_at: DateTime.now..DateTime.now + 1.day
    }
  end

  def invalid_invite
    errors.add(:invite, 'Invalid invitation credentials')
  end

end
