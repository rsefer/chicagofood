class CreateTries < ActiveRecord::Migration[5.1]
  def change
    create_table :tries do |t|
      t.references :venue, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
