class RenameTypeIdToVenuetypeIdInVenues < ActiveRecord::Migration[5.1]
  def change
    rename_column :venues, :type_id, :venuetype_id
  end
end
