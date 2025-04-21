class ChangeUsersIdToUuid < ActiveRecord::Migration[7.1]
  def up
    # Enable UUID extension
    enable_extension 'pgcrypto'

    # Create a new UUID column
    add_column :users, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    # Update foreign keys in related tables
    add_column :votes, :user_uuid, :uuid
    add_column :final_predictions, :user_uuid, :uuid

    # Update the foreign key references
    execute 'UPDATE votes SET user_uuid = users.uuid FROM users WHERE votes.user_id = users.id'
    execute 'UPDATE final_predictions SET user_uuid = users.uuid FROM users WHERE final_predictions.user_id = users.id'

    # Remove old foreign key columns
    remove_column :votes, :user_id
    remove_column :final_predictions, :user_id

    # Remove the old id column and rename uuid to id
    remove_column :users, :id
    rename_column :users, :uuid, :id

    # Make the UUID column the primary key
    execute 'ALTER TABLE users ADD PRIMARY KEY (id)'

    # Add new foreign key constraints
    rename_column :votes, :user_uuid, :user_id
    rename_column :final_predictions, :user_uuid, :user_id

    add_foreign_key :votes, :users
    add_foreign_key :final_predictions, :users
  end

  def down
    # This migration is not reversible
    raise ActiveRecord::IrreversibleMigration
  end
end
