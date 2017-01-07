class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.string      :token
      t.string      :recipient_email
      t.datetime    :accepted_at
      t.references  :admin
      t.boolean     :active, default: true

      t.timestamps null: false
    end
  end
end
