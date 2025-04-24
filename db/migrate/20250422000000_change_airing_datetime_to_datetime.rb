class ChangeAiringDatetimeToDatetime < ActiveRecord::Migration[8.0]
  def change
    change_column :drafts, :airing_datetime, :datetime
  end
end
