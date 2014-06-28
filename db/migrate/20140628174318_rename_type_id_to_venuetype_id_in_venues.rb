class RenameTypeIdToVenuetypeIdInVenues < ActiveRecord::Migration
  def change
    rename_column :venues, :type_id, :venuetype_id
  end
end
