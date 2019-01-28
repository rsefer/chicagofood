class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.references :user, index: true
      t.boolean :private
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
