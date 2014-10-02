class Eat < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  belongs_to :venue
  belongs_to :item_rating

  scope :withoutratings, -> { where('item_rating_id = ?', nil) }

  include Recent

end
