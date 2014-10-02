class Item < ActiveRecord::Base

  belongs_to :venue
  has_many :item_ratings, :dependent => :destroy
  has_many :eats, :dependent => :destroy

  scope :alpha, -> { order('name ASC') }

end
