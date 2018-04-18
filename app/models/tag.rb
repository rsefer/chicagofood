class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  default_scope { order('name ASC') }

  include Recent

  def venues
    Venue.where("array_to_string(tags, '||') ANY :id", id: self.id.to_s)
  end

  def hasParent
    unless self.parent_tag_id.nil?
      true
    else
      false
    end
  end

  def parent
    if self.parent_tag_id
      Tag.find(self.parent_tag_id)
    else
      nil
    end
  end

  def children
    Tag.where(parent_tag_id: self.id)
  end

  def venues_with_children
    tempTagList = Set.new [self]
    Tag.where(parent_tag_id: self.id).each do |n|
      tempTagList.add(n)
      Tag.where(parent_tag_id: n.id).each do |n2|
        tempTagList.add(n2)
        Tag.where(parent_tag_id: n2.id).each do |n3|
          tempTagList.add(n3)
          Tag.where(parent_tag_id: n3.id).each do |n4|
            tempTagList.add(n4)
            Tag.where(parent_tag_id: n4.id).each do |n5|
              tempTagList.add(n5)
            end
          end
        end
      end
    end
    venuesListSet = Set.new
    tempTagList.each do |n|
      # n.venues.each do |v|
        # venuesListSet.add(v)
      # end
    end
    venuesList = []
    venuesListSet.each do |v|
      venuesList.push(v)
    end
    venuesList
  end

  def sortable_name
		self.name.sub(/^(the|a|an|le|la|los|las)\s+/i, '').downcase
	end

end
