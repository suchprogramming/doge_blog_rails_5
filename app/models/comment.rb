class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :post

  validates :text, presence: true, length: { maximum: 1000 }

  default_scope { order(created_at: :asc) }

  def poly_parent
    self.commentable
  end

end
