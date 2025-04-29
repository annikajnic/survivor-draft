class ChangeEpisodeIdToUuid < ActiveRecord::Migration[8.0]
  def up
    # First, remove the existing primary key
    remove_column :episodes, :id

    # Add the new UUID column
    add_column :episodes, :id, :uuid, default: -> { "gen_random_uuid()" }, null: false

    # Add the primary key constraint
    execute "ALTER TABLE episodes ADD PRIMARY KEY (id);"

    # Update foreign key references in votes table
    remove_foreign_key :votes, :episodes
    change_column :votes, :episode_id, :uuid, using: 'episode_id::uuid'
    add_foreign_key :votes, :episodes
  end

  def down
    # Remove the foreign key first
    remove_foreign_key :votes, :episodes

    # Change the votes episode_id back to bigint
    change_column :votes, :episode_id, :bigint

    # Remove the UUID primary key
    remove_column :episodes, :id

    # Add back the auto-incrementing ID
    add_column :episodes, :id, :bigint, null: false
    execute "ALTER TABLE episodes ADD PRIMARY KEY (id);"
    execute "CREATE SEQUENCE episodes_id_seq;"
    execute "ALTER TABLE episodes ALTER COLUMN id SET DEFAULT nextval('episodes_id_seq');"
    execute "ALTER SEQUENCE episodes_id_seq OWNED BY episodes.id;"

    # Add back the foreign key
    add_foreign_key :votes, :episodes
  end
end
