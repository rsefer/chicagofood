class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :venue, index: true
      t.string :name

      t.timestamps
    end
  end
end
