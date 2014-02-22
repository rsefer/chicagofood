class RenameColumnRateridInRatings < ActiveRecord::Migration
  def self.up
    rename_column :ratings, :raterid, :user_id
  end

  def self.down
    rename_column :ratings, :user_id, :raterrid
  end
end
