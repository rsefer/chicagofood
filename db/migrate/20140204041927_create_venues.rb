class CreateVenues < ActiveRecord::Migration[5.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.string :url
      t.integer :typeid
      t.integer :yelpid

      t.timestamps
    end
  end
end
