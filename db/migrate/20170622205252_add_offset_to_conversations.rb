class AddOffsetToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :sendable_offset, :integer, default: 0
    add_column :conversations, :receivable_offset, :integer, default: 0
  end
end
