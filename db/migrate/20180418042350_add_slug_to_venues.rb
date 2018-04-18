class AddSlugToVenues < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :slug, :string
  end
end
