class AddSeasonNumberToEpisodes < ActiveRecord::Migration[7.1]
  def change
    add_column :episodes, :season_number, :integer, null: false, default: 1
  end
end
