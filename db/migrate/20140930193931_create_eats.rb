class CreateEats < ActiveRecord::Migration[5.1]
  def change
    create_table :eats do |t|
      t.references :item, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
