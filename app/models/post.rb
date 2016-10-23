class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  validates :title, presence: true
  validates :post_content, presence: true
end