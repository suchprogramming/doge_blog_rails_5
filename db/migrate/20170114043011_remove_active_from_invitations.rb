class RemoveActiveFromInvitations < ActiveRecord::Migration[5.0]
  def change
    remove_column :invitations, :active, :boolean
  end
end
