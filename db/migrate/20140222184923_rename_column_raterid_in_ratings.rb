class RenameColumnRateridInRatings < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :ratings, :raterid, :user_id
  end

  def self.down
    rename_column :ratings, :user_id, :raterrid
  end
end
