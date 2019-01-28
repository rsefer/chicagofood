class CreateItemRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :item_ratings do |t|
      t.references :item, index: true
      t.references :user, index: true
      t.boolean :liked, default: true

      t.timestamps
    end
  end
end
