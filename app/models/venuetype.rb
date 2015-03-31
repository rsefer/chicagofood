class Venuetype < ActiveRecord::Base
  has_many :venues

  default_scope { order('name ASC') }

  include Recent

  def hasParent
    unless self.parent_type_id.nil?
      true
    else
      false
    end
  end

  def parent
    if self.parent_type_id
      Venuetype.find(self.parent_type_id)
    else
      nil
    end
  end

  def isBar
    if self.id == 2 or (self.hasParent and self.parent.isBar)
      true
    else
      false
    end
  end

end
