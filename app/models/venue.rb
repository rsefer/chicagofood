class Venue < ActiveRecord::Base
	has_many :comments
	has_many :ratings
end
