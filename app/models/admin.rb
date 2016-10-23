class Admin < ApplicationRecord
  include ResourceOwnerHelper

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>", mobile: "50x50>" }, default_url: "/assets/doge-small.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage/
  validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]
  validates_attachment_size :avatar, in: 0..1.megabytes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, as: :postable
end