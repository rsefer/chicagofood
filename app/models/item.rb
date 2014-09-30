class Item < ActiveRecord::Base
  belongs_to :venue
  has_many :item_ratings
end
