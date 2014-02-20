class Venue < ActiveRecord::Base
	has_many :comments, :dependent => :destroy
	has_many :ratings, :dependent => :destroy
	has_many :tries, :dependent => :destroy
	
	def fulladdress
		if !self.street.blank?
			self.street + " " + self.city + ", " + self.state
		end
	end
	
	def fulladdress_withname
		if !self.fulladdress.blank?
			self.name + " " + self.fulladdress
		end
	end
	
end
