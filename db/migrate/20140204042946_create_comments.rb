class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :commenterid
      t.text :body
      t.references :venue, index: true

      t.timestamps
    end
  end
end
