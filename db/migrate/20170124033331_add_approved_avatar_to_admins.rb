class AddApprovedAvatarToAdmins < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :avatar_approved, :boolean, default: false
  end
end
