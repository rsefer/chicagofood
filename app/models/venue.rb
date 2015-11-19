class Venue < ActiveRecord::Base
	has_many :comments, :dependent => :destroy
	has_many :ratings, :dependent => :destroy
	has_many :tries, :dependent => :destroy
	has_many :items, :dependent => :destroy

	belongs_to :venuetype
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

	def hasExtras
		if self.byob or self.craftbeer or self.cocktails or self.latenight or self.cashonly
			true
		end
	end

	def sortable_name
		self.name.sub(/^(the|a|an)\s+/i, '').downcase
	end

end
