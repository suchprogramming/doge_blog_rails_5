class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  has_many :comments
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :post_content, presence: true

  def poly_parent
    self.postable
  end

  def self.search(term)
    term ? where('title LIKE ?', "%#{term}%") : all
  end

  def up_votes
    self.votes.where(direction: 'up').size
  end

  def down_votes
    self.votes.where(direction: 'down').size
  end

  def score
    up_votes - down_votes
  end

end
