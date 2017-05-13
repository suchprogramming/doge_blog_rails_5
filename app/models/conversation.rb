class Conversation < ApplicationRecord
  belongs_to :sendable, polymorphic: true
  belongs_to :receivable, polymorphic: true
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sendable_id, scope: :receivable_id

  scope :my_conversations, -> (current_any_scope) {
    where(sendable: current_any_scope).or(where(receivable: current_any_scope))
  }

  scope :between, -> (sendable, receivable) {
    where(sendable: sendable, receivable: receivable).or(where(sendable: receivable, receivable: sendable))
  }
end
