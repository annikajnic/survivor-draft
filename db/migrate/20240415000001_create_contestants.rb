class CreateContestants < ActiveRecord::Migration[7.0]
  def change
    create_table :contestants do |t|
      t.string :name, null: false
      t.string :status, null: false, default: 'active'

      t.timestamps
    end

    add_index :contestants, :name, unique: true
  end
end
