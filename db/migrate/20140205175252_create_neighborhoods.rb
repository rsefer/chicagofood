class CreateNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    create_table :neighborhoods do |t|
      t.string :name
      t.integer :parentneighborhoodid

      t.timestamps
    end
  end
end
