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

  def children
    Venuetype.where(parent_type_id: self.id)
  end

  def venues_with_children
    tempVenuetypeList = Set.new [self]
    Venuetype.where(parent_type_id: self.id).each do |n|
      tempVenuetypeList.add(n)
      Venuetype.where(parent_type_id: n.id).each do |n2|
        tempVenuetypeList.add(n2)
        Venuetype.where(parent_type_id: n2.id).each do |n3|
          tempVenuetypeList.add(n3)
          Venuetype.where(parent_type_id: n3.id).each do |n4|
            tempVenuetypeList.add(n4)
            Venuetype.where(parent_type_id: n4.id).each do |n5|
              tempVenuetypeList.add(n5)
            end
          end
        end
      end
    end
    venuesListSet = Set.new
    tempVenuetypeList.each do |n|
      n.venues.each do |v|
        venuesListSet.add(v)
      end
    end
    venuesList = []
    venuesListSet.each do |v|
      venuesList.push(v)
    end
    venuesList
  end

  def isBar
    if self.id == 2 or (self.hasParent and self.parent.isBar)
      true
    else
      false
    end
  end

  def sortable_name
		self.name.sub(/^(the|a|an)\s+/i, '').downcase
	end

end
