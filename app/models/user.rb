class User < ApplicationRecord
  include PolymorphicResourceHelper

  has_many :posts, as: :postable
  has_many :votes
  has_many :comments, as: :commentable
  has_attached_file :avatar,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "default-avatar_:style.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]
  validates_attachment_size :avatar, in: 0..1.megabytes
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true, length: { maximum: 12 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.search(term)
    term ? where('email LIKE ?', "%#{term}%") : all
  end

  def voted?(post_id = nil)
    return unless post_id

    direction = self.votes.where(user_id: id, voteable_id: post_id).first.try(:direction)

    direction ? direction : ''
  end
end
