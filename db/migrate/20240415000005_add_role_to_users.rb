class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :string, null: false, default: 'user'
    add_column :users, :status, :string, null: false, default: 'active'
  end
end
