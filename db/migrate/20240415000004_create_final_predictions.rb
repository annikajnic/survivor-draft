class CreateFinalPredictions < ActiveRecord::Migration[7.0]
  def change
    create_table :final_predictions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contestant, null: false, foreign_key: true
      t.integer :placement, null: false
      t.integer :jury_votes

      t.timestamps
    end

    add_index :final_predictions, [ :user_id, :placement ], unique: true
  end
end
