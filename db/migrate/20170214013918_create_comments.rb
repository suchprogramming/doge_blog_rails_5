class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.boolean :flagged, default: false

      t.references :commentable, polymorphic: true, index: true
      t.references :post, foreign_key: true

      t.timestamps null: false
    end
  end
end
