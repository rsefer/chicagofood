class ChangeDataTyppeForYelpid < ActiveRecord::Migration
  def self.up
    change_table :venues do |t|
      t.change :yelpid, :string
    end
  end
  def self.down
    change_table :venues do |t|
      t.change :yelpid, :integer
    end
  end
end
