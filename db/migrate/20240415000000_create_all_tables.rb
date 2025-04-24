class CreateAllTables < ActiveRecord::Migration[7.1]
  def change
    # Enable UUID extension
    enable_extension 'pgcrypto'

    # Create users table first
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :role, null: false, default: 'player', enum_type: [ 'player', 'admin' ]
      t.string :status, null: false, default: 'active', enum_type: [ 'active', 'eliminated' ]

      t.timestamps
    end
    add_index :users, :email, unique: true

    # Create contestants table
    create_table :contestants, id: :uuid do |t|
      t.string :name, null: false
      t.string :tribe, null: false
      t.integer :season_number, null: false
      t.string :status, null: false, default: 'active', enum_type: [ 'active', 'eliminated', 'winner' ]

      t.timestamps
    end
    add_index :contestants, :name, unique: true

    # Create episodes table
    create_table :episodes do |t|
      t.integer :number, null: false
      t.datetime :air_date, null: false
      t.datetime :voting_deadline, null: false
      t.datetime :open_deadline, null: false
      t.integer :duration, null: false, default: 90
      t.integer :season_number, null: false
      t.string :status, null: false, default: 'upcoming', enum_type: [ 'upcoming', 'airing', 'finished' ]
      t.boolean :is_final, default: false

      t.timestamps
    end
    add_index :episodes, :number, unique: true

    # Create drafts table
    create_table :drafts, id: :uuid do |t|
      t.integer :season_number, null: false
      t.references :draft_owner, null: false, type: :uuid, foreign_key: { to_table: :users }
      t.integer :episodes_count, null: false
      t.datetime :airing_datetime, null: false
      t.boolean :votes_first_episode, default: false, null: false

      t.timestamps
    end
    add_index :drafts, :season_number
    add_index :drafts, :airing_datetime

    # Create draft_contestants join table
    create_table :draft_contestants, id: :uuid do |t|
      t.references :draft, null: false, type: :uuid, foreign_key: true
      t.references :contestant, null: false, type: :uuid, foreign_key: true
      t.timestamps
    end
    add_index :draft_contestants, [ :draft_id, :contestant_id ], unique: true

    # Create draft_players join table
    create_table :draft_players, id: :uuid do |t|
      t.references :draft, null: false, type: :uuid, foreign_key: true
      t.references :user, null: false, type: :uuid, foreign_key: { to_table: :users }
      t.timestamps
    end
    add_index :draft_players, [ :draft_id, :player_id ], unique: true

    # Create draft_votes join table
    create_table :draft_votes, id: :uuid do |t|
      t.references :draft, null: false, type: :uuid, foreign_key: true
      t.references :user, null: false, type: :uuid, foreign_key: { to_table: :users }
      t.references :votes, null: false, type: :uuid, foreign_key: true
      t.timestamps
    end
    add_index :draft_votes, [ :draft_id, :votes_id ], unique: true

    # Create votes table
    create_table :votes do |t|
      t.references :draft, null: false, type: :uuid, foreign_key: true
      t.references :user, null: false, type: :uuid, foreign_key: true
      t.references :contestant, null: false, type: :uuid, foreign_key: true
      t.references :episode, null: false, foreign_key: true

      t.timestamps
    end
    add_index :votes, [ :user_id, :contestant_id ], unique: true
    add_index :votes, [ :user_id, :episode_id ], unique: true
  end
end
