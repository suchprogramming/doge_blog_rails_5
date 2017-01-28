class AddTypeToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :type, :string, default: 'Admin'
  end
end
