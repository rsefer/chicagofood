class CreateVenuetypes < ActiveRecord::Migration[5.1]
  def change
    create_table :venuetypes do |t|
      t.string :name
      t.integer :parenttypeid

      t.timestamps
    end
  end
end
