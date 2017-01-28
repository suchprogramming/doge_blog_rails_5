class AddExpirationToInvitations < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :expires_at, :datetime
  end
end
