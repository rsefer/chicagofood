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

  def children
    Neighborhood.where(parent_neighborhood_id: self.id)
  end

  def venues_with_children
    tempNeighborhoodList = Set.new [self]
    Neighborhood.where(parent_neighborhood_id: self.id).each do |n|
      tempNeighborhoodList.add(n)
      Neighborhood.where(parent_neighborhood_id: n.id).each do |n2|
        tempNeighborhoodList.add(n2)
        Neighborhood.where(parent_neighborhood_id: n2.id).each do |n3|
          tempNeighborhoodList.add(n3)
          Neighborhood.where(parent_neighborhood_id: n3.id).each do |n4|
            tempNeighborhoodList.add(n4)
            Neighborhood.where(parent_neighborhood_id: n4.id).each do |n5|
              tempNeighborhoodList.add(n5)
            end
          end
        end
      end
    end
    venuesListSet = Set.new
    tempNeighborhoodList.each do |n|
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

  def sortable_name
		self.name.sub(/^(the|a|an)\s+/i, '').downcase
	end

end
