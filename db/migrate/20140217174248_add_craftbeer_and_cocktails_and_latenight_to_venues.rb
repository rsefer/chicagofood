class AddCraftbeerAndCocktailsAndLatenightToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :craftbeer, :boolean
    add_column :venues, :cocktails, :boolean
    add_column :venues, :latenight, :boolean
  end
end
