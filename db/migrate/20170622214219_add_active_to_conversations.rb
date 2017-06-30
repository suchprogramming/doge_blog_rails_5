class AddActiveToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :sendable_active, :boolean, default: true
    add_column :conversations, :receivable_active, :boolean, default: true
  end
end
