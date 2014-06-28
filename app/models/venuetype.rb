class Venuetype < ActiveRecord::Base
  has_many :venues

  default_scope { order('name ASC') }

  include Recent

  def hasParent
    if self.parent_type_id
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

end
