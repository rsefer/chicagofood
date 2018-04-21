class AddTagtypeToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :tagtype, :string
  end
end
