class CreateVenuetypes < ActiveRecord::Migration
  def change
    create_table :venuetypes do |t|
      t.string :name
      t.integer :parenttypeid

      t.timestamps
    end
  end
end
