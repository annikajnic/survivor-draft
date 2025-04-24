class AddColumnTribeToContestants < ActiveRecord::Migration[8.0]
  def change
    add_column :contestants, :tribe, :string
  end
end
