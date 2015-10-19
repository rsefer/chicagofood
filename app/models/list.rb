class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_items, :dependent => :destroy
  has_many :venues, :through => :list_items

  include Recent

  default_scope { order('title ASC') }
  scope :publicLists, -> { where('private = ?', false) }

  def venue_count
    self.list_items.size
  end

  def hasDates
    datesCount = 0
    self.list_items.each do |list_item|
      if list_item.date
        datesCount += 1
      end
    end
    if datesCount > 0
      true
    else
      false
    end
  end

end
