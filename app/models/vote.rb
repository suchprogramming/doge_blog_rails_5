class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  has_one :user

  validates :direction, presence: true
  validates_inclusion_of :direction, in: %w( up down )
  validates_uniqueness_of :voteable_id, scope: :user_id
end
