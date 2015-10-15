class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_items, :dependent => :destroy

  include Recent

  default_scope { order('title ASC') }
  scope :publicLists, -> { where('private = ?', false) }

  def venue_count
    self.list_items.size
  end

end
