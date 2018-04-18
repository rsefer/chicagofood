class ConvertTagIdColumnToArray < ActiveRecord::Migration[5.1]
  def change
    change_column :venues, :tag_id, :string, array: true, default: [], using: "(string_to_array(tag_id, ','))"
  end
end
