class Venue < ActiveRecord::Base
	has_many :comments, :dependent => :destroy
	has_many :ratings, :dependent => :destroy
	has_many :tries, :dependent => :destroy
	belongs_to :venuetype
	belongs_to :neighborhood

	include Recent

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

end
