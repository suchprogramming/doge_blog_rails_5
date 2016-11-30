class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  validates :title, presence: true
  validates :post_content, presence: true

  def poly_parent
    self.postable
  end

  def self.search(term)
    term ? where('title LIKE ?', "%#{term}%") : all
  end

end
