class AddPrivateToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :private, :boolean, :default => false
  end
end
