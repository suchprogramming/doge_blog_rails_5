class AddPolymorphismToPosts < ActiveRecord::Migration[5.0]
  def change
    change_table :posts do
      add_reference :posts, :postable, polymorphic: true, index: true
      remove_reference :posts, :user
    end
  end
end
