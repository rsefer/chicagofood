class CreateListItems < ActiveRecord::Migration[5.1]
  def change
    create_table :list_items do |t|
      t.references :list, index: true
      t.date :date
      t.text :notes

      t.timestamps
    end
  end
end
