class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contestant, null: false, foreign_key: true
      t.references :episode, null: false, foreign_key: true

      t.timestamps
    end

    add_index :votes, [ :user_id, :contestant_id ], unique: true
    add_index :votes, [ :user_id, :episode_id ], unique: true
  end
end
