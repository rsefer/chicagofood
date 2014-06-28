class Neighborhood < ActiveRecord::Base
  has_many :venues

  default_scope { order('name ASC') }

  include Recent

  def hasParent
    if self.parent_neighborhood_id
      true
    else
      false
    end
  end

  def parent
    if self.parent_neighborhood_id
      Neighborhood.find(self.parent_neighborhood_id)
    else
      nil
    end
  end

end
