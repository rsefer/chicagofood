class Venue < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, :use => :slugged

	has_many :comments, :dependent => :destroy
	has_many :ratings, :dependent => :destroy
	has_many :tries, :dependent => :destroy
	has_many :items, :dependent => :destroy
	has_many :list_items, :dependent => :destroy

	belongs_to :tag
	belongs_to :neighborhood

	validates :street, :city, :state, presence: true
	validates :name, uniqueness: { case_sensitive: false, message: ' - This venue already exists!' }

	geocoded_by :fulladdress
	after_validation :geocode

	include Recent

	def self.search(q)
		where("name LIKE ?", "%" + q + "%")
	end

	def rating(rounded = true)
		if self.ratings.length > 0
			self.ratings.average('rating')
		else
			0
		end
	end

	def neighborhood_name
		self.neighborhood.sortable_name
	end

	def tag_list
		tag_list = []
		self.tags.each do |tag|
			tag_list.push(Tag.find(tag))
		end
		tag_list
	end

	def tag_name
		self.tag.sortable_name
	end

	def hasaddress
		if !self.street.blank?
			true
		else
			false
		end
	end

	def fulladdress
		if self.hasaddress
			self.street + " " + self.city + ", " + self.state
		end
	end

	def fulladdress_withname
		if !self.fulladdress.blank?
			self.name + " " + self.fulladdress
		end
	end

	def addressDisplay
		self.street + '<br/>' + self.city + ', ' + self.state
	end

	def hasExtras
		if self.byob or self.craftbeer or self.cocktails or self.latenight or self.cashonly or self.outdoor
			true
		end
	end

	def sortable_name
		self.name.sub(/^(the|a|an)\s+/i, '').downcase
	end

end
