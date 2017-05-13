class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :messageable, polymorphic: true, index: true
      t.references :conversation, foreign_key: true, index: true

      t.string :text
      t.boolean :new, default: true
      t.boolean :hidden, default: false

      t.timestamps
    end
  end
end
