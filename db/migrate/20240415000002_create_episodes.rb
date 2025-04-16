class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.integer :number, null: false
      t.datetime :air_date, null: false
      t.datetime :voting_deadline, null: false
      t.string :status, null: false, default: 'upcoming'
      t.boolean :is_final, default: false

      t.timestamps
    end

    add_index :episodes, :number, unique: true
  end
end
