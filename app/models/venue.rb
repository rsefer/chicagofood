class Venue < ActiveRecord::Base
	has_many :comments
	has_many :ratings
	
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
