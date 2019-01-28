class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :raterid
      t.integer :rating
      t.references :venue, index: true

      t.timestamps
    end
  end
end
