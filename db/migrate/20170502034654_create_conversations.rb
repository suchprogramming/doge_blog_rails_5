class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.references :sendable, polymorphic: true, index: true
      t.references :receivable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
