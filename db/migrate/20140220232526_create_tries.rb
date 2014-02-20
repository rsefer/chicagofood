class CreateTries < ActiveRecord::Migration
  def change
    create_table :tries do |t|
      t.references :venue, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
