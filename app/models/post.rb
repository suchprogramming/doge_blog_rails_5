class Post < ApplicationRecord
  include Filterable

  belongs_to :postable, polymorphic: true
  has_many :comments, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :post_content, presence: true, length: { maximum: 2000 }

  scope :active, -> { where(active: true) }
  scope :date_scope, -> (start_date) { where created_at: start_date..Time.current }

  def poly_parent
    self.postable
  end

  def self.post_search(term)
    term ? where('title ILIKE ?', "%#{term}%") : all
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
