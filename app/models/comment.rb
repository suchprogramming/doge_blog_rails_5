class Comment < ApplicationRecord
  include Filterable

  belongs_to :commentable, polymorphic: true
  belongs_to :post

  validates :text, presence: true, length: { maximum: 1000 }

  default_scope { order(created_at: :asc) }

  def poly_parent
    self.commentable
  end

  def page_num
    (self.class.where("id <= ?", read_attribute(:id)).order("id asc").count.to_f / 25).ceil
  end

  def self.comment_search(term)
    term ? where('text ILIKE ?', "%#{term}%") : all
  end
end
