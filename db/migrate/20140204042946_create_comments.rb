class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commenterid
      t.text :body
      t.references :venue, index: true

      t.timestamps
    end
  end
end
