class ItemRating < ActiveRecord::Base
  belongs_to :item
  belongs_to :user
  has_one :eat

  include Recent

  default_scope { joins(:item).order('items.name') }

end
