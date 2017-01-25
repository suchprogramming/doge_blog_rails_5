class AddApprovedAvatarToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_approved, :boolean, default: false
  end
end
